import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/features/add_address/data/models/city_model.dart';
import 'package:greenhub/features/add_address/data/models/region_model.dart';
import 'package:greenhub/features/address/data/models/address_model.dart';
import 'package:greenhub/features/edit_address/data/params/edit_address_params.dart';
import 'package:greenhub/features/edit_address/data/repo/edit_address_repo.dart';
import 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(EditAddressInitial());

  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController addressTitleController = TextEditingController();
  final TextEditingController floorController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegionModel? selectedRegion;
  CityModel? selectedCity;
  List<RegionModel> regions = [];
  List<CityModel> cities = [];
  int _addressId = 0;
  bool isDefault = false;
  String type = 'home';

  void initAddress(AddressModel address) {
    _addressId = address.id;
    addressTitleController.text = address.title;
    streetController.text = address.streetAddress;
    buildingController.text = address.building ?? '';
    apartmentController.text = address.apartment ?? '';
    landmarkController.text = address.landmark ?? '';
    districtController.text = address.district;
    floorController.text = address.floor;
    isDefault = address.isDefault;
    type = address.type;

    selectedRegion = address.region;
    selectedCity = address.city;

    loadRegions();
    if (selectedRegion != null) {
      loadCities(selectedRegion!.id);
    }
  }

  void changeType(String newType) {
    type = newType;
    emit(EditAddressTypeChanged(type));
  }

  void toggleIsDefault(bool? value) {
    isDefault = value ?? false;
    emit(EditAddressDefaultChanged(isDefault));
  }

  Future<void> loadRegions() async {
    emit(RegionsLoading());
    final result = await EditAddressRepo.getRegions();
    result.fold((error) => emit(RegionsError(error: error)), (data) {
      regions = data;
      if (selectedRegion != null) {
        final match = regions.where((r) => r.id == selectedRegion!.id).toList();
        if (match.isNotEmpty) {
          selectedRegion = match.first;
        } else {
          selectedRegion = null;
          selectedCity = null;
        }
      }
      emit(RegionsLoaded());
    });
  }

  Future<void> loadCities(int regionId) async {
    emit(CitiesLoading());
    final result = await EditAddressRepo.getCities(regionId);
    result.fold((error) => emit(CitiesError(error: error)), (data) {
      cities = data;
      if (selectedCity != null) {
        final match = cities.where((c) => c.id == selectedCity!.id).toList();
        if (match.isNotEmpty) {
          selectedCity = match.first;
        } else {
          selectedCity = null;
        }
      }
      emit(CitiesLoaded());
    });
  }

  void selectRegion(RegionModel region) {
    if (selectedRegion?.id != region.id) {
      selectedRegion = region;
      selectedCity = null; // Reset city when region changes
      cities.clear();
      loadCities(region.id);
    }
  }

  void selectCity(CityModel city) {
    selectedCity = city;
    emit(EditAddressInitial());
  }

  Future<void> updateAddress() async {
    if (!formKey.currentState!.validate()) return;
    emit(EditAddressSaving());

    final params = EditAddressParams(
      title: addressTitleController.text,
      type: type,
      latitude: 0.0, // Should be fetched from map picker
      longitude: 0.0, // Should be fetched from map picker
      buildingNumber: buildingController.text,
      floor: floorController.text,
      apartment: apartmentController.text,
      isDefault: isDefault ? 1 : 0,
      regionId: selectedRegion?.id,
      cityId: selectedCity?.id,
      notes: landmarkController.text,
      streetAddress: streetController.text,
      district: districtController.text,
    );

    final result = await EditAddressRepo.updateAddress(_addressId, params);

    result.fold(
      (error) => emit(EditAddressError(error: error)),
      (data) => emit(EditAddressSaved()),
    );
  }

  Future<void> deleteAddress() async {
    emit(EditAddressDeleting());
    final result = await EditAddressRepo.deleteAddress(_addressId);

    result.fold(
      (error) => emit(EditAddressDeleteError(error: error)),
      (message) => emit(EditAddressDeleted()),
    );
  }
}
