import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/enable_notification_model.dart';

sealed class EnableNotificationState {
  const EnableNotificationState();
}

final class EnableNotificationInitial extends EnableNotificationState {}

final class EnableNotificationLoading extends EnableNotificationState {
  const EnableNotificationLoading();
}

final class EnableNotificationSuccess extends EnableNotificationState {
  final EnableNotificationModel data;
  const EnableNotificationSuccess(this.data);
}

final class EnableNotificationError extends EnableNotificationState {
  final ErrorEntity error;
  const EnableNotificationError(this.error);
}
