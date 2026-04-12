import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/negotiation_model.dart';
import '../../data/models/reject_negotiation_model.dart';
import '../../data/models/accept_negotiation_model.dart';

sealed class NegotiationsState extends Equatable {
  const NegotiationsState();

  @override
  List<Object?> get props => [];
}

final class NegotiationsInitial extends NegotiationsState {}

final class NegotiationsLoading extends NegotiationsState {}

final class NegotiationsSuccess extends NegotiationsState {
  final List<NegotiationModel> negotiations;

  const NegotiationsSuccess(this.negotiations);

  @override
  List<Object?> get props => [negotiations];
}

final class NegotiationsError extends NegotiationsState {
  final ErrorEntity error;

  const NegotiationsError(this.error);

  @override
  List<Object?> get props => [error];
}

final class NegotiationRejectLoading extends NegotiationsState {}

final class NegotiationRejectSuccess extends NegotiationsState {
  final RejectNegotiationModel data;

  const NegotiationRejectSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

final class NegotiationRejectError extends NegotiationsState {
  final ErrorEntity error;

  const NegotiationRejectError(this.error);

  @override
  List<Object?> get props => [error];
}

final class NegotiationAcceptLoading extends NegotiationsState {}

final class NegotiationAcceptSuccess extends NegotiationsState {
  final AcceptNegotiationModel data;

  const NegotiationAcceptSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

final class NegotiationAcceptError extends NegotiationsState {
  final ErrorEntity error;

  const NegotiationAcceptError(this.error);

  @override
  List<Object?> get props => [error];
}
