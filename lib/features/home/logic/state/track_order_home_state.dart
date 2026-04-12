import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/order_tracking/data/models/tracking_model.dart';

sealed class TrackOrderHomeState extends Equatable {
  const TrackOrderHomeState();

  @override
  List<Object> get props => [];
}

class TrackOrderHomeInitial extends TrackOrderHomeState {}

class TrackOrderHomeLoading extends TrackOrderHomeState {}

class TrackOrderHomeSuccess extends TrackOrderHomeState {
  final TrackingModel model;

  const TrackOrderHomeSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class TrackOrderHomeError extends TrackOrderHomeState {
  final ErrorEntity errorEntity;

  const TrackOrderHomeError(this.errorEntity);

  @override
  List<Object> get props => [errorEntity];
}
