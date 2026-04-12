import 'package:equatable/equatable.dart';

class NegotiationModel extends Equatable {
  final int? id;
  final int? orderId;
  final int? driverId;
  final String? offeredPrice;
  final String? message;
  final String? status;
  final String? statusLabel;
  final String? createdAt;
  final String? updatedAt;
  final NegotiationDriverModel? driver;

  const NegotiationModel({
    this.id,
    this.orderId,
    this.driverId,
    this.offeredPrice,
    this.message,
    this.status,
    this.statusLabel,
    this.createdAt,
    this.updatedAt,
    this.driver,
  });

  factory NegotiationModel.fromJson(Map<String, dynamic> json) {
    return NegotiationModel(
      id: json['id'],
      orderId: json['order_id'],
      driverId: json['driver_id'],
      offeredPrice: json['offered_price'],
      message: json['message'],
      status: json['status'],
      statusLabel: json['status_label'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      driver: json['driver'] != null ? NegotiationDriverModel.fromJson(json['driver']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'driver_id': driverId,
      'offered_price': offeredPrice,
      'message': message,
      'status': status,
      'status_label': statusLabel,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'driver': driver?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        driverId,
        offeredPrice,
        message,
        status,
        statusLabel,
        createdAt,
        updatedAt,
        driver,
      ];
}

class NegotiationDriverModel extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? rateing;
  final String? commissionRate;
  final bool? isOnline;
  final Map<String, dynamic>? currentLocation;
  final String? faceImage;
  final List<NegotiationVehicleModel>? vehicles;
  final String? createdAt;
  final String? updatedAt;

  const NegotiationDriverModel({
    this.id,
    this.name,
    this.phone,
    this.rateing,
    this.commissionRate,
    this.isOnline,
    this.currentLocation,
    this.faceImage,
    this.vehicles,
    this.createdAt,
    this.updatedAt,
  });

  factory NegotiationDriverModel.fromJson(Map<String, dynamic> json) {
    return NegotiationDriverModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      rateing: json['rateing'],
      commissionRate: json['commission_rate'],
      isOnline: json['is_online'],
      currentLocation: json['current_location'] != null ? Map<String, dynamic>.from(json['current_location']) : null,
      faceImage: json['face_image'],
      vehicles: json['vehicles'] != null
          ? List<NegotiationVehicleModel>.from(json['vehicles'].map((x) => NegotiationVehicleModel.fromJson(x)))
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'rateing': rateing,
      'commission_rate': commissionRate,
      'is_online': isOnline,
      'current_location': currentLocation,
      'face_image': faceImage,
      'vehicles': vehicles?.map((x) => x.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        rateing,
        commissionRate,
        isOnline,
        currentLocation,
        faceImage,
        vehicles,
        createdAt,
        updatedAt,
      ];
}

class NegotiationVehicleModel extends Equatable {
  final int? id;
  final int? driverId;
  final int? type;
  final String? plateNumber;
  final String? status;
  final String? vehicleSize;
  final bool? isDefault;
  final Map<String, dynamic>? images;
  final Map<String, dynamic>? vehicleType;
  final String? createdAt;
  final String? updatedAt;

  const NegotiationVehicleModel({
    this.id,
    this.driverId,
    this.type,
    this.plateNumber,
    this.status,
    this.vehicleSize,
    this.isDefault,
    this.images,
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
  });

  factory NegotiationVehicleModel.fromJson(Map<String, dynamic> json) {
    return NegotiationVehicleModel(
      id: json['id'],
      driverId: json['driver_id'],
      type: json['type'],
      plateNumber: json['plate_number'],
      status: json['status'],
      vehicleSize: json['vehicle_size'],
      isDefault: json['is_default'],
      images: json['images'] != null ? Map<String, dynamic>.from(json['images']) : null,
      vehicleType: json['vehicle_type'] != null ? Map<String, dynamic>.from(json['vehicle_type']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'type': type,
      'plate_number': plateNumber,
      'status': status,
      'vehicle_size': vehicleSize,
      'is_default': isDefault,
      'images': images,
      'vehicle_type': vehicleType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        driverId,
        type,
        plateNumber,
        status,
        vehicleSize,
        isDefault,
        images,
        vehicleType,
        createdAt,
        updatedAt,
      ];
}
