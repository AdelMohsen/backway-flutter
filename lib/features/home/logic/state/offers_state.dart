import 'package:equatable/equatable.dart';

import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/offers_model.dart';

sealed class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object?> get props => [];
}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  final OffersModel offersModel;

  const OffersSuccess(this.offersModel);

  @override
  List<Object?> get props => [offersModel];
}

class OffersError extends OffersState {
  final ErrorEntity error;

  const OffersError(this.error);

  @override
  List<Object?> get props => [error];
}
