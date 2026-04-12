import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/city_model.dart';
import '../data/models/region_model.dart';
import '../data/params/add_address_params.dart';
import '../data/repo/add_address_repo.dart';
import 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial()) {
    _initializeControllers();
    loadRegions();
  }

  // Text Controllers
  late final TextEditingController searchController;
  late final TextEditingController governorateController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  late final TextEditingController streetController;
  late final TextEditingController buildingController;
  late final TextEditingController floorController;
  late final TextEditingController apartmentController;
  late final TextEditingController landmarkController;
  late final TextEditingController notesController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Data
  List<RegionModel> regions = [];
  List<CityModel> cities = [];
  RegionModel? selectedRegion;
  CityModel? selectedCity;

  // Hardcoded for now based on UI needs for add address form
  double latitude = 21.37630;
  double longitude = 39.79460;
  bool isDefault = false;
  String type = 'home';

  void changeType(String newType) {
    type = newType;
    emit(AddAddressTypeChanged(type));
  }

  void toggleIsDefault(bool? value) {
    isDefault = value ?? false;
    emit(AddAddressDefaultChanged(isDefault));
  }

  void _initializeControllers() {
    searchController = TextEditingController();
    governorateController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
    streetController = TextEditingController();
    buildingController = TextEditingController();
    floorController = TextEditingController();
    apartmentController = TextEditingController();
    landmarkController = TextEditingController();
    notesController = TextEditingController();
  }

  //----------------------------------API CALLS----------------------------------//

  Future<void> loadRegions() async {
    emit(RegionsLoading());
    final response = await AddAddressRepo.getRegions();
    response.fold((failure) => emit(RegionsError(failure)), (success) {
      regions = success.data;
      emit(RegionsLoaded(regions));
    });
  }

  Future<void> loadCities(int regionId) async {
    emit(CitiesLoading());
    final response = await AddAddressRepo.getCities(regionId);
    response.fold((failure) => emit(CitiesError(failure)), (success) {
      cities = success.data;
      emit(CitiesLoaded(cities));
    });
  }

  void selectRegion(RegionModel region) {
    selectedRegion = region;
    selectedCity = null;
    cities = [];
    governorateController.text = region.name;
    cityController.clear();
    loadCities(region.id);
  }

  void selectCity(CityModel city) {
    selectedCity = city;
    cityController.text = city.name;
    emit(CitiesLoaded(cities)); // Emit state to refresh UI binding if needed
  }

  Future<void> saveAddress() async {
    if (!formKey.currentState!.validate()) return;

    emit(AddAddressSaving());

    final params = AddAddressParams(
      type: type,
      address: searchController.text.isNotEmpty
          ? searchController.text
          : 'Default Address Title',
      latitude: latitude,
      longitude: longitude,
      buildingNumber: buildingController.text,
      floor: floorController.text,
      apartment: apartmentController.text,
      isDefault: isDefault,
      regionId: selectedRegion?.id.toString(),
      cityId: selectedCity?.id.toString(),
      notes: notesController.text,
      streetAddress: streetController.text,
      district: districtController.text,
    );

    final response = await AddAddressRepo.addAddress(params);
    response.fold(
      (failure) => emit(AddAddressError(failure)),
      (success) => emit(AddAddressSaved(success)),
    );
  }

  /// Clear all fields
  void clearAllFields() {
    searchController.clear();
    governorateController.clear();
    cityController.clear();
    districtController.clear();
    streetController.clear();
    buildingController.clear();
    floorController.clear();
    apartmentController.clear();
    landmarkController.clear();
    notesController.clear();
    selectedRegion = null;
    selectedCity = null;
    cities.clear();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    governorateController.dispose();
    cityController.dispose();
    districtController.dispose();
    streetController.dispose();
    buildingController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    landmarkController.dispose();
    notesController.dispose();
    return super.close();
  }
}
