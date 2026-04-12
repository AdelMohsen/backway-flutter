import 'package:equatable/equatable.dart';

import 'city_model.dart';
import 'region_model.dart';

class AddAddressModel extends Equatable {
  const AddAddressModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final AddAddressDataModel? data;

  factory AddAddressModel.fromJson(Map<String, dynamic> json) {
    return AddAddressModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AddAddressDataModel.fromJson(json['data'])
          : null,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}

class AddAddressDataModel extends Equatable {
  const AddAddressDataModel({
    required this.id,
    required this.type,
    required this.title,
    required this.streetAddress,
    required this.building,
    required this.floor,
    required this.apartment,
    required this.district,
    required this.landmark,
    required this.isDefault,
    required this.region,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String type;
  final String title;
  final String streetAddress;
  final String? building;
  final String? floor;
  final String? apartment;
  final String district;
  final String? landmark;
  final bool isDefault;
  final RegionModel? region;
  final CityModel? city;
  final String createdAt;
  final String updatedAt;

  factory AddAddressDataModel.fromJson(Map<String, dynamic> json) {
    return AddAddressDataModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      streetAddress: json['street_address'] ?? '',
      building: json['building'],
      floor: json['floor'],
      apartment: json['apartment'],
      district: json['district'] ?? '',
      landmark: json['landmark'],
      isDefault: json['is_default'] ?? false,
      region: json['region'] != null
          ? RegionModel.fromJson(json['region'])
          : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
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
    createdAt,
    updatedAt,
  ];
}
