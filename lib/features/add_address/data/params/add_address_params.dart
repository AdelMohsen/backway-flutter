import 'package:equatable/equatable.dart';

class AddAddressParams extends Equatable {
  const AddAddressParams({
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.buildingNumber,
    required this.floor,
    required this.apartment,
    required this.isDefault,
    this.regionId,
    this.cityId,
    required this.notes,
    required this.streetAddress,
    required this.district,
  });

  final String type;
  final String address;
  final double latitude;
  final double longitude;
  final String buildingNumber;
  final String floor;
  final String apartment;
  final bool isDefault;
  final String? regionId;
  final String? cityId;
  final String notes;
  final String streetAddress;
  final String district;

  Map<String, dynamic> returnedMap() {
    return {
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'building': buildingNumber,
      'floor': floor,
      'apartment': apartment,
      'is_default': isDefault,
      'region_id': regionId,
      'city_id': cityId,
      'notes': notes,
      'street_address': streetAddress,
      'district': district,
    }..removeWhere((key, value) => value == null || value == '');
  }

  @override
  List<Object?> get props => [
    type,
    address,
    latitude,
    longitude,
    buildingNumber,
    floor,
    apartment,
    isDefault,
    regionId,
    cityId,
    notes,
    streetAddress,
    district,
  ];
}
