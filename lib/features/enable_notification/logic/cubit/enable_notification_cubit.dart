import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/params/enable_notification_params.dart';
import '../../data/repository/enable_notification_repo.dart';
import '../state/enable_notification_state.dart';

class EnableNotificationCubit extends Cubit<EnableNotificationState> {
  EnableNotificationCubit() : super(EnableNotificationInitial());

  Future<void> toggleNotification(bool isEnabled) async {
    emit(const EnableNotificationLoading());

    final response = await EnableNotificationRepo.toggleNotification(
      EnableNotificationParams(notificationsEnabled: isEnabled),
    );

    response.fold(
      (failure) {
        emit(EnableNotificationError(failure));
      },
      (success) {
        emit(EnableNotificationSuccess(success));
      },
    );
  }
}
