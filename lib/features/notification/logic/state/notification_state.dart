import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/notification_model.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationItem> notifications;
  final bool hasReachedMax;
  final int currentPage;
  final int unreadCount;

  const NotificationSuccess({
    required this.notifications,
    required this.hasReachedMax,
    required this.currentPage,
    required this.unreadCount,
  });

  NotificationSuccess copyWith({
    List<NotificationItem>? notifications,
    bool? hasReachedMax,
    int? currentPage,
    int? unreadCount,
  }) {
    return NotificationSuccess(
      notifications: notifications ?? this.notifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

final class NotificationPaginationLoading extends NotificationSuccess {
  const NotificationPaginationLoading({
    required super.notifications,
    required super.hasReachedMax,
    required super.currentPage,
    required super.unreadCount,
  });
}

final class NotificationError extends NotificationState {
  final ErrorEntity error;
  const NotificationError(this.error);
}
