import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/toast/toast_service.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/models/notification_model.dart';
import '../../data/params/notification_params.dart';
import '../../data/repository/notification_repository.dart';
import '../state/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  List<NotificationItem> notifications = [];

  Future<void> getNotifications({bool isRefresh = false}) async {
    if (state is NotificationLoading) return;

    if (isRefresh ||
        state is NotificationInitial ||
        state is NotificationError) {
      emit(NotificationLoading());
    } else if (state is NotificationSuccess) {
      final currentState = state as NotificationSuccess;
      if (currentState.hasReachedMax) return;
      emit(NotificationPaginationLoading(
        notifications: currentState.notifications,
        hasReachedMax: currentState.hasReachedMax,
        currentPage: currentState.currentPage,
        unreadCount: currentState.unreadCount,
      ));
    }

    int page = 1;
    List<NotificationItem> currentNotifications = [];
    int unreadCount = 0;

    if (state is NotificationPaginationLoading) {
      final currentState = state as NotificationPaginationLoading;
      page = currentState.currentPage + 1;
      currentNotifications = currentState.notifications;
      unreadCount = currentState.unreadCount;
    }

    final response = await NotificationRepository.getNotifications(
      NotificationParams(
        page: page,
        lang: mainAppBloc.globalLang,
      ),
    );

    if (isClosed) return;

    response.fold(
      (failure) => emit(NotificationError(failure)),
      (success) {
        final List<NotificationItem> newNotifications = success.data?.data ?? [];
        final int totalPages = success.data?.lastPage ?? 1;
        final int currentPage = success.data?.currentPage ?? 1;
        final bool hasReachedMax = currentPage >= totalPages;

        if (page == 1) {
          notifications = newNotifications;
        } else {
          notifications.addAll(newNotifications);
        }

        emit(NotificationSuccess(
          notifications: notifications,
          hasReachedMax: hasReachedMax,
          currentPage: currentPage,
          unreadCount: success.unreadCount ?? unreadCount,
        ));
      },
    );
  }

  Future<void> onRefresh() async {
    await getNotifications(isRefresh: true);
  }

  Future<void> readAllNotifications({BuildContext? context}) async {
    final response = await NotificationRepository.readAllNotifications();
    response.fold(
      (failure) {
        final targetContext = context ?? CustomNavigator.safeContext;
        if (targetContext != null && targetContext.mounted) {
          ToastService.showError(
            failure.message,
            targetContext,
          );
        }
      },
      (success) async {
        final targetContext = context ?? CustomNavigator.safeContext;
        if (targetContext != null && targetContext.mounted) {
          ToastService.showSuccess(
            success['message']?.toString() ??
                AppStrings.allNotificationsMarkedAsRead.tr,
            targetContext,
          );
        }
        await onRefresh();
      },
    );
  }
}
