import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';

abstract class OrderTrackingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderTrackingInitial extends OrderTrackingState {}

class OrderTrackingLoading extends OrderTrackingState {}

class OrderTrackingLoaded extends OrderTrackingState {
  final TrackingModel orderData;

  OrderTrackingLoaded(this.orderData);

  @override
  List<Object?> get props => [orderData];
}

class OrderTrackingError extends OrderTrackingState {
  final ErrorEntity error;

  OrderTrackingError(this.error);

  @override
  List<Object?> get props => [error];
}
