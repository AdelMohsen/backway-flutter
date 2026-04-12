import 'package:equatable/equatable.dart';

class EditAddressParams extends Equatable {
  final String title;
  final String type;
  final num latitude;
  final num longitude;
  final String buildingNumber;
  final String floor;
  final String apartment;
  final int isDefault;
  final int? regionId;
  final int? cityId;
  final String notes;
  final String streetAddress;
  final String district;

  const EditAddressParams({
    required this.title,
    required this.type,
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

  Map<String, dynamic> returnedMap() {
    return {
      if (title.isNotEmpty) 'title': title,
      if (type.isNotEmpty) 'type': type,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingNumber.isNotEmpty) 'building': buildingNumber,
      if (floor.isNotEmpty) 'floor': floor,
      if (apartment.isNotEmpty) 'apartment': apartment,
      'is_default': isDefault,
      if (regionId != null) 'region_id': regionId,
      if (cityId != null) 'city_id': cityId,
      if (notes.isNotEmpty) 'landmark': notes,
      if (streetAddress.isNotEmpty) 'street_address': streetAddress,
      if (district.isNotEmpty) 'district': district,
    };
  }

  @override
  List<Object?> get props => [
    title,
    type,
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
