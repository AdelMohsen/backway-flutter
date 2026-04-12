import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/home/logic/state/track_order_home_state.dart';
import 'package:greenhub/features/home/ui/pages/home_screen.dart';
import 'package:greenhub/features/home/ui/widgets/search_home.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/user/logic/user_cubit.dart';
import 'package:greenhub/features/user/logic/user_state.dart';
import 'package:greenhub/features/notification/logic/cubit/notification_unread_count_cubit.dart';
import 'package:greenhub/features/notification/logic/state/notification_unread_count_state.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';

import '../../logic/cubit/track_order_home_cubit.dart';

class HomeHeaderSliver extends StatefulWidget {
  const HomeHeaderSliver({super.key});

  @override
  State<HomeHeaderSliver> createState() => _HomeHeaderSliverState();
}

class _HomeHeaderSliverState extends State<HomeHeaderSliver> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackOrderHomeCubit(),
      child: SliverAppBar(
        expandedHeight: 250,
        collapsedHeight: 70,
        pinned: true,
        backgroundColor: AppColors.kWhite,
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate collapse progress
            final expandedHeight = 240.0;
            final collapsedHeight = 70.0;
            final currentHeight = constraints.maxHeight;
            final progress =
                ((currentHeight - collapsedHeight) /
                        (expandedHeight - collapsedHeight))
                    .clamp(0.0, 1.0);

            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.kLightGreen, AppColors.primaryGreenHub],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(progress > 0.1 ? 28 : 0),
                  bottomRight: Radius.circular(progress > 0.1 ? 28 : 0),
                ),
              ),
              child: Stack(
                children: [
                  // Decorative Waves (fade out when collapsing)
                  if (progress > 0.1)
                    Opacity(
                      opacity: progress,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 5,
                            child: SvgPicture.asset(AppSvg.vector2),
                          ),
                          Positioned(
                            top: 10,
                            left: -5,
                            child: SvgPicture.asset(AppSvg.vector2),
                          ),
                        ],
                      ),
                    ),

                  // Content
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Top Row - Location & Icons (ALWAYS VISIBLE)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      CustomNavigator.push(Routes.ADDRESS);
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.kWhiteOpacity16,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 12,
                                              left: 8,
                                            ),
                                            child: Container(
                                              width: 28,
                                              height: 28,
                                              padding: const EdgeInsets.all(6),
                                              decoration: const BoxDecoration(
                                                color: AppColors.kLightGreen,
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                AppSvg.location,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                      AppColors.kWhite,
                                                      BlendMode.srcIn,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child:
                                                  BlocBuilder<
                                                    UserCubit,
                                                    UserState
                                                  >(
                                                    builder: (context, state) {
                                                      final user =
                                                          state is UserLoaded
                                                          ? state.user
                                                          : null;
                                                      return Text(
                                                        user
                                                                ?.defaultAddress
                                                                ?.title ??
                                                            AppStrings
                                                                .addNewAddress
                                                                .tr,
                                                        style: AppTextStyles
                                                            .ibmPlexSansSize10w500White,
                                                      );
                                                    },
                                                  ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_right,
                                            color: AppColors.kWhite,
                                            size: 17,
                                          ),
                                          const SizedBox(width: 4),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    _buildCircleIcon(
                                      icon: AppSvg.messages,
                                      onTap: () {
                                        CustomNavigator.push(Routes.MESSAGES);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    BlocProvider(
                                      create: (context) =>
                                          NotificationUnreadCountCubit()
                                            ..startPolling(),
                                      child:
                                          BlocBuilder<
                                            NotificationUnreadCountCubit,
                                            NotificationUnreadCountState
                                          >(
                                            builder: (context, state) {
                                              bool hasUnread = false;
                                              if (state
                                                  is NotificationUnreadCountSuccess) {
                                                hasUnread =
                                                    (state.model.unreadCount ??
                                                        0) >
                                                    0;
                                              }
                                              return _buildCircleIcon(
                                                icon: AppSvg.notification,
                                                hasBadge: hasUnread,
                                                onTap: () {
                                                  CustomNavigator.push(
                                                    Routes.NOTIFICATIONS,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Title Area (COLLAPSES - fades out)
                            if (progress > 0.1)
                              Opacity(
                                opacity: progress,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                AppStrings.homeHeaderTitle.tr,
                                                style: AppTextStyles
                                                    .ibmPlexSansSize24w700White
                                                    .copyWith(fontSize: 22),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Image.asset(
                                              AppImages.box,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          AppStrings.homeHeaderSubtitle.tr,
                                          style: AppTextStyles
                                              .ibmPlexSansSize12w400WhiteOpacity,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            // Search Bar (COLLAPSES - fades out)
                            if (progress > 0.1)
                              Opacity(
                                opacity: progress,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SearchHome(
                                          controller: _searchController,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      BlocConsumer<
                                        TrackOrderHomeCubit,
                                        TrackOrderHomeState
                                      >(
                                        listener: (context, state) {
                                          if (state is TrackOrderHomeError) {
                                            ToastService.showError(
                                              state.errorEntity.message,
                                              context,
                                            );
                                          } else if (state
                                              is TrackOrderHomeSuccess) {
                                            final orderId =
                                                state.model.order.id;
                                            CustomNavigator.push(
                                              Routes.ORDER_TRACKING,
                                              pathParameters: {
                                                'orderId': orderId.toString(),
                                              },
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (state
                                                  is! TrackOrderHomeLoading) {
                                                if (_searchController.text
                                                    .trim()
                                                    .isEmpty) {
                                                  ToastService.showError(
                                                    AppStrings
                                                        .pleaseEnterAValidTrackingNumber
                                                        .tr,
                                                    context,
                                                  );
                                                } else {
                                                  context
                                                      .read<
                                                        TrackOrderHomeCubit
                                                      >()
                                                      .trackOrder(
                                                        _searchController.text,
                                                      );
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 44,
                                              height: 44,
                                              decoration: const BoxDecoration(
                                                color:
                                                    AppColors.primaryGreenHub,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child:
                                                  state is TrackOrderHomeLoading
                                                  ? const Padding(
                                                      padding: EdgeInsets.all(
                                                        4.0,
                                                      ),
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: AppColors
                                                                .kWhite,
                                                            strokeWidth: 2,
                                                          ),
                                                    )
                                                  : SvgPicture.asset(
                                                      AppSvg.directUp,
                                                      colorFilter:
                                                          const ColorFilter.mode(
                                                            AppColors.kWhite,
                                                            BlendMode.srcIn,
                                                          ),
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircleIcon({
    required String icon,
    bool hasBadge = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.kWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(icon, color: AppColors.kWhite),
          ),
          if (hasBadge)
            Positioned(
              top: 10,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.kRed,
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: AppColors.kWhite, width: 1.5),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
