import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/logout_user_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/more/ui/widgets/more_menu_item.dart';
import '../../../user/logic/user_cubit.dart';
import '../../../user/logic/user_state.dart';
import '../../../auth/logout/logic/cubit/logout_cubit.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: Builder(
        builder: (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
            ),
            child: CustomScaffoldWidget(
              needAppbar: false,
              backgroundColor: AppColors.kWhite,
              child: Column(
                children: [
                  /// 🔹 Gradient Header + Profile Card
                  GradientHeaderLayout(
                    showAction: false,
                    title: AppStrings.more.tr,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        /// 🔹 Profile Card,
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            final user = state is UserLoaded
                                ? state.user
                                : null;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE8F9D4), // Light lime green
                                      Color.fromRGBO(
                                        209,
                                        254,
                                        248,
                                        1,
                                      ), // Very light teal/white
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Profile Info (Right)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            user?.name ?? '...',
                                            style: AppTextStyles
                                                .ibmPlexSansSize16w600Black,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              user?.defaultAddress != null
                                                  ? const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 16,
                                                      color: Color(0xFF009688),
                                                    )
                                                  : const SizedBox.shrink(),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  user?.defaultAddress?.title ??
                                                      "",
                                                  style: AppTextStyles
                                                      .ibmPlexSansSize10w400Grey
                                                      .copyWith(
                                                        color: const Color(
                                                          0xFF009688,
                                                        ),
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Edit Button (Left)
                                    InkWell(
                                      onTap: () {
                                        CustomNavigator.push(
                                          Routes.EDIT_PROFILE,
                                        );
                                      },
                                      child: Container(
                                        width: 81,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.03,
                                              ),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                start: 14,
                                                end: 14,
                                              ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                AppStrings.edit.tr,
                                                style: AppTextStyles
                                                    .ibmPlexSansSize10w500White
                                                    .copyWith(
                                                      color: AppColors.kBlack,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                              ),
                                              SvgPicture.asset(
                                                AppSvg.edit,
                                                width: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                MoreMenuItem(
                                  title: AppStrings.editAccountDetails.tr,
                                  description: AppStrings.changeAccountInfo.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.profile,
                                    width: 30,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.EDIT_PROFILE);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.aboutApp.tr,
                                  description: AppStrings.learnMoreAboutUs.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.about,
                                    width: 20,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.ABOUT);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.contactUs.tr,
                                  description: AppStrings.contactUsDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.support,
                                    width: 20,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.CONTACT_US);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.myAddresses.tr,
                                  description: AppStrings.addOrEditAddresses.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.locationMap,
                                    width: 26,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.ADDRESS);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.myWallet.tr,
                                  description: AppStrings.walletDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.wallet,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.WALLET);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.settings.tr,
                                  description: AppStrings.settingsDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.settings,
                                    width: 28,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.APP_SETTINGS);
                                  },
                                ),
                                _divider(),
                                MoreMenuItem(
                                  title: AppStrings.logout.tr,
                                  description: AppStrings.logoutDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.logout,
                                    width: 24,
                                  ),
                                  isDestructive: true,
                                  onTap: () {
                                    final logoutCubit = context
                                        .read<LogoutCubit>();
                                    LogoutUserBottomSheet.show(
                                      context,
                                      title: AppStrings.logout.tr,
                                      subtitle: AppStrings
                                          .logoutConfirmationSubtitle
                                          .tr,
                                      retryButtonText: AppStrings.logout.tr,
                                      backToLoginText:
                                          AppStrings.backToLogin.tr,
                                      onRetry: () {
                                        CustomNavigator.pop();
                                        logoutCubit.logout(context);
                                      },
                                      onBackToLogin: () {
                                        CustomNavigator.pop();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _divider() => const Divider(
    height: 1,
    indent: 20,
    endIndent: 20,
    color: Color(0xFFF7F7F7),
  );
}
