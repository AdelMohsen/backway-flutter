import '../../../../core/shared/entity/error_entity.dart';
import '../data/models/add_address_model.dart';
import '../data/models/city_model.dart';
import '../data/models/region_model.dart';

abstract class AddAddressState {
  const AddAddressState();
}

class AddAddressInitial extends AddAddressState {}

// --- Save Address States ---
class AddAddressSaving extends AddAddressState {}

class AddAddressSaved extends AddAddressState {
  final AddAddressModel success;
  AddAddressSaved(this.success);
}

class AddAddressError extends AddAddressState {
  final ErrorEntity message;
  AddAddressError(this.message);
}

// --- Region States ---
class RegionsLoading extends AddAddressState {}

class RegionsLoaded extends AddAddressState {
  final List<RegionModel> regions;
  RegionsLoaded(this.regions);
}

class RegionsError extends AddAddressState {
  final ErrorEntity error;
  RegionsError(this.error);
}

// --- City States ---
class CitiesLoading extends AddAddressState {}

class CitiesLoaded extends AddAddressState {
  final List<CityModel> cities;
  CitiesLoaded(this.cities);
}

class CitiesError extends AddAddressState {
  final ErrorEntity error;
  CitiesError(this.error);
}

class AddAddressTypeChanged extends AddAddressState {
  final String type;
  AddAddressTypeChanged(this.type);
}

class AddAddressDefaultChanged extends AddAddressState {
  final bool isDefault;
  AddAddressDefaultChanged(this.isDefault);
}
