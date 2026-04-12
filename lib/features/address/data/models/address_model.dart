import 'package:equatable/equatable.dart';
import 'package:greenhub/features/add_address/data/models/city_model.dart';
import 'package:greenhub/features/add_address/data/models/region_model.dart';

class AddressResponseModel extends Equatable {
  final bool success;
  final List<AddressModel> data;

  const AddressResponseModel({required this.success, required this.data});

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) {
    return AddressResponseModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class AddressModel extends Equatable {
  final int id;
  final String type;
  final String title;
  final String streetAddress;
  final String? building;
  final String floor;
  final String? apartment;
  final String district;
  final String? landmark;
  final bool isDefault;
  final RegionModel region;
  final CityModel city;

  const AddressModel({
    required this.id,
    required this.type,
    required this.title,
    required this.streetAddress,
    this.building,
    required this.floor,
    this.apartment,
    required this.district,
    this.landmark,
    required this.isDefault,
    required this.region,
    required this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      streetAddress: json['street_address'] ?? '',
      building: json['building'],
      floor: json['floor'] ?? '',
      apartment: json['apartment'],
      district: json['district'] ?? '',
      landmark: json['landmark'],
      isDefault: json['is_default'] ?? false,
      region: RegionModel.fromJson(json['region'] ?? {}),
      city: CityModel.fromJson(json['city'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'street_address': streetAddress,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'district': district,
      'landmark': landmark,
      'is_default': isDefault,
      'region': region.toJson(),
      'city': city.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    streetAddress,
    building,
    floor,
    apartment,
    district,
    landmark,
    isDefault,
    region,
    city,
  ];
}
