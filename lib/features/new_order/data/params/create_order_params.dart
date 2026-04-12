import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CreateOrderParams extends Equatable {
  final String type;
  final int? vehicleTypeId;
  final String? serviceType;
  final int? packageTypeId;
  final int? vehiclesCount;
  final String? packageSize;
  final String? packageWeight;
  final String? notes;
  final double? pickupLat;
  final double? pickupLng;
  final String? pickupAddress;
  final String? deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final String? deliveryContactPhone;
  final String? scheduledAt;
  final List<File>? packageImages;

  const CreateOrderParams({
    required this.type,
    this.vehicleTypeId,
    this.serviceType,
    this.packageTypeId,
    this.vehiclesCount,
    this.packageSize,
    this.packageWeight,
    this.notes,
    this.pickupLat,
    this.pickupLng,
    this.pickupAddress,
    this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
    this.deliveryContactPhone,
    this.scheduledAt,
    this.packageImages,
  });

  Future<Map<String, dynamic>> returnedMap() async {
    final map = <String, dynamic>{
      'type': type,
      'vehicle_type_id': vehicleTypeId,
      'service_type': serviceType,
      'package_type_id': packageTypeId,
      'vehicles_count': vehiclesCount,
      'package_size': packageSize,
      'package_weight': packageWeight,
      'notes': notes,
      'pickup_lat': pickupLat,
      'pickup_lng': pickupLng,
      'pickup_address': pickupAddress,
      'delivery_address': deliveryAddress,
      'delivery_lat': deliveryLat,
      'delivery_lng': deliveryLng,
      'delivery_contact_phone': deliveryContactPhone,
      'scheduled_at': scheduledAt,
    };

    // Add package images as multipart files
    if (packageImages != null && packageImages!.isNotEmpty) {
      for (int i = 0; i < packageImages!.length; i++) {
        map['package_images[$i]'] = await MultipartFile.fromFile(
          packageImages![i].path,
          filename: packageImages![i].path.split(Platform.pathSeparator).last,
        );
      }
    }

    // Remove null or empty values
    map.removeWhere((key, value) => value == null || value == '');

    return map;
  }

  @override
  List<Object?> get props => [
    type,
    vehicleTypeId,
    serviceType,
    packageTypeId,
    vehiclesCount,
    packageSize,
    packageWeight,
    notes,
    pickupLat,
    pickupLng,
    pickupAddress,
    deliveryAddress,
    deliveryLat,
    deliveryLng,
    deliveryContactPhone,
    scheduledAt,
    packageImages,
  ];
}
