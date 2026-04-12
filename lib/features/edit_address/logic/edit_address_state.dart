import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';

sealed class EditAddressState extends Equatable {
  const EditAddressState();

  @override
  List<Object> get props => [];
}

final class EditAddressInitial extends EditAddressState {}

final class EditAddressSaving extends EditAddressState {}

final class EditAddressSaved extends EditAddressState {}

final class EditAddressError extends EditAddressState {
  final ErrorEntity error;

  const EditAddressError({required this.error});

  @override
  List<Object> get props => [error];
}

// Delete States
final class EditAddressDeleting extends EditAddressState {}

final class EditAddressDeleted extends EditAddressState {}

final class EditAddressDeleteError extends EditAddressState {
  final ErrorEntity error;

  const EditAddressDeleteError({required this.error});

  @override
  List<Object> get props => [error];
}

// Regions States
final class RegionsLoading extends EditAddressState {}

final class RegionsLoaded extends EditAddressState {}

final class RegionsError extends EditAddressState {
  final ErrorEntity error;

  const RegionsError({required this.error});

  @override
  List<Object> get props => [error];
}

// Cities States
final class CitiesLoading extends EditAddressState {}

final class CitiesLoaded extends EditAddressState {}

final class CitiesError extends EditAddressState {
  final ErrorEntity error;

  const CitiesError({required this.error});

  @override
  List<Object> get props => [error];
}

final class EditAddressTypeChanged extends EditAddressState {
  final String type;
  const EditAddressTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}

final class EditAddressDefaultChanged extends EditAddressState {
  final bool isDefault;
  const EditAddressDefaultChanged(this.isDefault);
  @override
  List<Object> get props => [isDefault];
}
