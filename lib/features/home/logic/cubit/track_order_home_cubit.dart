import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/home/logic/state/track_order_home_state.dart';

import 'package:greenhub/features/order_tracking/data/params/tracking_params.dart';
import '../../data/params/track_order_home_repository.dart';

class TrackOrderHomeCubit extends Cubit<TrackOrderHomeState> {
  TrackOrderHomeCubit() : super(TrackOrderHomeInitial());

  static TrackOrderHomeCubit get(context) =>
      BlocProvider.of<TrackOrderHomeCubit>(context);

  Future<void> trackOrder(String orderNumber) async {
    if (orderNumber.trim().isEmpty) {
      // Don't do anything if empty
      return;
    }

    emit(TrackOrderHomeLoading());

    final params = TrackingParams(orderNumber: orderNumber.trim());

    final result = await TrackOrderHomeRepository.trackOrder(params);

    result.fold(
      (error) {
        emit(TrackOrderHomeError(error));
      },
      (model) {
        emit(TrackOrderHomeSuccess(model));
      },
    );
  }
}
