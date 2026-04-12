import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/notification/data/params/notification_unread_count_params.dart';
import 'package:greenhub/features/notification/data/repository/notification_unread_count_repository.dart';
import 'package:greenhub/features/notification/logic/state/notification_unread_count_state.dart';

class NotificationUnreadCountCubit extends Cubit<NotificationUnreadCountState> {
  NotificationUnreadCountCubit() : super(NotificationUnreadCountInitial());

  Timer? _timer;

  void startPolling() {
    getUnreadCount();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getUnreadCount();
    });
  }

  void stopPolling() {
    _timer?.cancel();
  }

  Future<void> getUnreadCount() async {
    if (state is! NotificationUnreadCountSuccess && state is! NotificationUnreadCountError) {
      emit(NotificationUnreadCountLoading());
    }

    final result = await NotificationUnreadCountRepository.getUnreadCount(
      const NotificationUnreadCountParams(),
    );

    result.fold(
      (error) => emit(NotificationUnreadCountError(error: error)),
      (model) => emit(NotificationUnreadCountSuccess(model: model)),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
