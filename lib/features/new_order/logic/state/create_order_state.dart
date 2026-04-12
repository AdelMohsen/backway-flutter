import 'package:equatable/equatable.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/create_order_model.dart';
import '../../data/models/package_type_model.dart';
import '../../data/models/vehicle_type_model.dart';

sealed class CreateOrderState {
  const CreateOrderState();
}

final class CreateOrderInitial extends CreateOrderState {}

// ─── Create Order States ────────────────────────────────────────────────────

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final CreateOrderResponseModel response;
  const CreateOrderSuccess(this.response);
}

final class CreateOrderError extends CreateOrderState {
  final ErrorEntity error;
  const CreateOrderError(this.error);
}

// ─── Vehicle Types States ───────────────────────────────────────────────────

final class VehicleTypesLoading extends CreateOrderState {}

final class VehicleTypesLoaded extends CreateOrderState {
  final List<VehicleTypeModel> vehicleTypes;
  const VehicleTypesLoaded(this.vehicleTypes);
}

final class VehicleTypesError extends CreateOrderState {
  final ErrorEntity error;
  const VehicleTypesError(this.error);
}

// ─── Package Types States ───────────────────────────────────────────────────

final class PackageTypesLoading extends CreateOrderState {}

final class PackageTypesLoaded extends CreateOrderState {
  final List<PackageTypeModel> packageTypes;
  const PackageTypesLoaded(this.packageTypes);
}

final class PackageTypesError extends CreateOrderState {
  final ErrorEntity error;
  const PackageTypesError(this.error);
}
