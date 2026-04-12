import 'package:equatable/equatable.dart';

class CreateOrderResponseModel extends Equatable {
  final bool success;
  final String message;
  final CreateOrderModel? data;

  const CreateOrderResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CreateOrderModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }

  @override
  List<Object?> get props => [success, message, data];
}

class CreateOrderModel extends Equatable {
  final int id;
  final String orderNumber;
  final Map<String, dynamic>? status;
  final Map<String, dynamic>? type;
  final Map<String, dynamic>? serviceType;
  final String? vehiclesCount;
  final String? notes;
  final Map<String, dynamic>? pickup;
  final Map<String, dynamic>? delivery;
  final Map<String, dynamic>? package;
  final Map<String, dynamic>? pricing;
  final String? scheduledAt;
  final String? acceptedAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final String? cancelledAt;
  final Map<String, dynamic>? driver;
  final List<dynamic>? negotiations;
  final String createdAt;
  final String updatedAt;

  const CreateOrderModel({
    required this.id,
    required this.orderNumber,
    this.status,
    this.type,
    this.serviceType,
    this.vehiclesCount,
    this.notes,
    this.pickup,
    this.delivery,
    this.package,
    this.pricing,
    this.scheduledAt,
    this.acceptedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
    this.driver,
    this.negotiations,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      id: json['id'],
      orderNumber: json['order_number'] ?? '',
      status: json['status'],
      type: json['type'],
      serviceType: json['service_type'],
      vehiclesCount: json['vehicles_count']?.toString(),
      notes: json['notes'],
      pickup: json['pickup'],
      delivery: json['delivery'],
      package: json['package'],
      pricing: json['pricing'],
      scheduledAt: json['scheduled_at'],
      acceptedAt: json['accepted_at'],
      pickedUpAt: json['picked_up_at'],
      deliveredAt: json['delivered_at'],
      cancelledAt: json['cancelled_at'],
      driver: json['driver'],
      negotiations: json['negotiations'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'status': status,
      'type': type,
      'service_type': serviceType,
      'vehicles_count': vehiclesCount,
      'notes': notes,
      'pickup': pickup,
      'delivery': delivery,
      'package': package,
      'pricing': pricing,
      'scheduled_at': scheduledAt,
      'accepted_at': acceptedAt,
      'picked_up_at': pickedUpAt,
      'delivered_at': deliveredAt,
      'cancelled_at': cancelledAt,
      'driver': driver,
      'negotiations': negotiations,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    status,
    type,
    serviceType,
    vehiclesCount,
    notes,
    pickup,
    delivery,
    package,
    pricing,
    scheduledAt,
    acceptedAt,
    pickedUpAt,
    deliveredAt,
    cancelledAt,
    driver,
    negotiations,
    createdAt,
    updatedAt,
  ];
}
