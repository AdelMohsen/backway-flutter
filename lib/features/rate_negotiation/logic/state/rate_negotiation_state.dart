import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/rate_negotiation/data/models/rate_negotiation_model.dart';

abstract class RateNegotiationState extends Equatable {
  const RateNegotiationState();

  @override
  List<Object?> get props => [];
}

class RateNegotiationInitial extends RateNegotiationState {}

class RateNegotiationLoading extends RateNegotiationState {}

class RateNegotiationSuccess extends RateNegotiationState {
  final RateNegotiationModel model;

  const RateNegotiationSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class RateNegotiationError extends RateNegotiationState {
  final ErrorEntity error;

  const RateNegotiationError(this.error);

  @override
  List<Object?> get props => [error];
}
