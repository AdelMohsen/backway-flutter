import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_details/data/models/cancel_order_model.dart';

sealed class CancelOrderDetailsState extends Equatable {
  const CancelOrderDetailsState();

  @override
  List<Object?> get props => [];
}

final class CancelOrderDetailsInitial extends CancelOrderDetailsState {}

final class CancelOrderDetailsLoading extends CancelOrderDetailsState {}

final class CancelOrderDetailsSuccess extends CancelOrderDetailsState {
  final CancelOrderResponseModel model;

  const CancelOrderDetailsSuccess({required this.model});

  @override
  List<Object?> get props => [model];
}

final class CancelOrderDetailsError extends CancelOrderDetailsState {
  final ErrorEntity error;

  const CancelOrderDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
