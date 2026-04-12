import 'package:equatable/equatable.dart';
import 'package:greenhub/core/shared/entity/error_entity.dart';
import 'package:greenhub/features/address/data/models/address_model.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  const AddressLoaded({required this.addresses});

  @override
  List<Object> get props => [addresses];
}

final class AddressError extends AddressState {
  final ErrorEntity error;

  const AddressError({required this.error});

  @override
  List<Object> get props => [error];
}
