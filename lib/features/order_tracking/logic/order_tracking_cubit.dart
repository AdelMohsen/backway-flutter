import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';
import 'package:greenhub/features/order_tracking/data/params/tracking_params.dart';
import 'package:greenhub/features/order_tracking/data/repository/order_tracking_repository.dart';
import 'package:greenhub/features/order_tracking/logic/order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  OrderTrackingCubit() : super(OrderTrackingInitial());

  TrackingModel? _orderData;

  TrackingModel? get orderData => _orderData;
  int? _currentOrderId;

  /// Load order tracking data
  Future<void> loadOrderTracking(int orderId) async {
    _currentOrderId = orderId;
    emit(OrderTrackingLoading());

    final params = TrackingParams(id: orderId);
    final result = await OrderTrackingRepository.trackOrder(params);

    result.fold(
      (error) => emit(OrderTrackingError(error)),
      (data) {
        _orderData = data;
        emit(OrderTrackingLoaded(data));
      },
    );
  }

  /// Refresh tracking data
  Future<void> refreshTracking() async {
    if (_currentOrderId == null) return;
    
    // Optional: could emit a specific refreshing state if needed 
    // but the requirement is to use pull-to-refresh, which handles its own UI
    // For now we just re-fetch and emit Loaded or Error.

    final params = TrackingParams(id: _currentOrderId!);
    final result = await OrderTrackingRepository.trackOrder(params);

    result.fold(
      (error) => emit(OrderTrackingError(error)),
      (data) {
        _orderData = data;
        emit(OrderTrackingLoaded(data));
      },
    );
  }
}

