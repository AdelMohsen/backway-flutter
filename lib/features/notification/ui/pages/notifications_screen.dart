import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/features/notification/logic/cubit/notification_cubit.dart';
import 'package:greenhub/features/notification/logic/state/notification_state.dart';
import 'package:greenhub/features/notification/ui/widgets/notification_card.dart';
import 'package:greenhub/features/notification/ui/widgets/notification_shimmer.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/services/toast/toast_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NotificationCubit>().getNotifications();
    }
  }

  void _handleNotificationTap(
    BuildContext context,
    String notificationType,
    String? orderId,
  ) {
    final type = NotificationCard.resolveType(notificationType);

    switch (type) {
      case NotificationType.orderSuccess:
        if (orderId != null) {
          context.pushNamed(Routes.ORDER_DETAILS, extra: int.tryParse(orderId));
        }
        break;
      case NotificationType.message:
        if (orderId != null) {
          context.pushNamed(
            Routes.NEGOTIATION_OFFERS,
            extra: int.tryParse(orderId),
          );
        }
        break;
      case NotificationType.offer:
        if (orderId != null) {
          context.pushNamed(
            Routes.NEGOTIATION_OFFERS,
            extra: int.tryParse(orderId),
          );
        }
        break;
      case NotificationType.update:
        // Handle update navigation if needed
        break;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color(0xffF9F9F9),
        child: GradientHeaderLayout(
          trailing: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              final cubit = NotificationCubit.get(context);
              if (cubit.notifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return InkWell(
                onTap: () {
                  if (state is NotificationSuccess && state.unreadCount == 0) {
                    ToastService.showInfo(
                      mainAppBloc.isArabic
                          ? "جميع الإشعارات مقروئة بالفعل"
                          : "All notifications are already read",
                      context,
                    );
                    return;
                  }
                  cubit.readAllNotifications(context: context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    mainAppBloc.isArabic ? "قرائة الكل" : "read all",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),

          title: AppStrings.notifications.tr,
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const NotificationShimmer();
              }

              if (state is NotificationError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: MainText(
                      text: AppStrings.errorLoadingNotifications.tr,
                      style: AppTextStyles.cairoW400Size12,
                    ),
                  ),
                );
              }

              if (state is NotificationSuccess) {
                final notifications = state.notifications;

                if (notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.notificationEmpty, height: 200),
                        const SizedBox(height: 20),
                        Text(
                          mainAppBloc.isArabic
                              ? "لا توجد إشعارات بعد"
                              : "no notifications",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<NotificationCubit>().onRefresh(),
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                    itemCount: state.hasReachedMax
                        ? notifications.length
                        : notifications.length + 1,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 1),
                    itemBuilder: (context, index) {
                      if (index >= notifications.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final notification = notifications[index];
                      return NotificationCard(
                        title: mainAppBloc.isArabic
                            ? (notification.titleLocalized ??
                                  notification.title ??
                                  '')
                            : (notification.title ?? ''),
                        body: mainAppBloc.isArabic
                            ? (notification.bodyLocalized ??
                                  notification.body ??
                                  '')
                            : (notification.body ?? ''),
                        time: timeago.format(
                          DateTime.tryParse(notification.createdAt ?? '') ??
                              DateTime.now(),
                          locale: mainAppBloc.globalLang,
                        ),
                        type: NotificationCard.resolveType(notification.type),
                        isUnread: !(notification.isRead ?? true),
                        iconUrl: notification.icon,
                        orderId:
                            notification.extraData != null &&
                                notification.extraData!['order_id'] != null
                            ? notification.extraData!['order_id'].toString()
                            : null,
                        onTap: () => _handleNotificationTap(
                          context,
                          notification.type ?? '',
                          notification.extraData != null &&
                                  notification.extraData!['order_id'] != null
                              ? notification.extraData!['order_id'].toString()
                              : null,
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
