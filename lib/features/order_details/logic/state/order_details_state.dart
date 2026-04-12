import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/orders/data/models/orders_model.dart';

sealed class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object?> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  final OrderModel order;

  const OrderDetailsLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderDetailsError extends OrderDetailsState {
  final ErrorEntity error;

  const OrderDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
