import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/notification/data/models/notification_unread_count_model.dart';

sealed class NotificationUnreadCountState {}

class NotificationUnreadCountInitial extends NotificationUnreadCountState {}

class NotificationUnreadCountLoading extends NotificationUnreadCountState {}

class NotificationUnreadCountSuccess extends NotificationUnreadCountState {
  final NotificationUnreadCountModel model;
  NotificationUnreadCountSuccess({required this.model});
}

class NotificationUnreadCountError extends NotificationUnreadCountState {
  final ErrorEntity error;
  NotificationUnreadCountError({required this.error});
}
