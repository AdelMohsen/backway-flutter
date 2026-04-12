import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int? id;
  final String? orderNumber;
  final StatusModel? status;
  final TypeModel? type;
  final ServiceTypeModel? serviceType;
  final int? vehiclesCount;
  final String? notes;
  final ParticipantModel? pickup;
  final ParticipantModel? delivery;
  final PackageModel? package;
  final PricingModel? pricing;
  final String? scheduledAt;
  final String? acceptedAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final String? cancelledAt;
  final DriverModel? driver;
  final List<NegotiationModel>? negotiations;
  final ExternalVehicleTypeModel? vehicleType;
  final String? createdAt;
  final String? updatedAt;

  const OrderModel({
    this.id,
    this.orderNumber,
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
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      status: json['status'] != null ? StatusModel.fromJson(json['status']) : null,
      type: json['type'] != null ? TypeModel.fromJson(json['type']) : null,
      serviceType: json['service_type'] != null ? ServiceTypeModel.fromJson(json['service_type']) : null,
      vehiclesCount: json['vehicles_count'],
      notes: json['notes'],
      pickup: json['pickup'] != null ? ParticipantModel.fromJson(json['pickup']) : null,
      delivery: json['delivery'] != null ? ParticipantModel.fromJson(json['delivery']) : null,
      package: json['package'] != null ? PackageModel.fromJson(json['package']) : null,
      pricing: json['pricing'] != null ? PricingModel.fromJson(json['pricing']) : null,
      scheduledAt: json['scheduled_at'],
      acceptedAt: json['accepted_at'],
      pickedUpAt: json['picked_up_at'],
      deliveredAt: json['delivered_at'],
      cancelledAt: json['cancelled_at'],
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      negotiations: json['negotiations'] != null
          ? List<NegotiationModel>.from(json['negotiations'].map((x) => NegotiationModel.fromJson(x)))
          : null,
      vehicleType: json['vehicle_type'] != null ? ExternalVehicleTypeModel.fromJson(json['vehicle_type']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'status': status?.toJson(),
      'type': type?.toJson(),
      'service_type': serviceType?.toJson(),
      'vehicles_count': vehiclesCount,
      'notes': notes,
      'pickup': pickup?.toJson(),
      'delivery': delivery?.toJson(),
      'package': package?.toJson(),
      'pricing': pricing?.toJson(),
      'scheduled_at': scheduledAt,
      'accepted_at': acceptedAt,
      'picked_up_at': pickedUpAt,
      'delivered_at': deliveredAt,
      'cancelled_at': cancelledAt,
      'driver': driver?.toJson(),
      'negotiations': negotiations?.map((x) => x.toJson()).toList(),
      'vehicle_type': vehicleType?.toJson(),
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
        vehicleType,
        createdAt,
        updatedAt,
      ];
}

class StatusModel extends Equatable {
  final String? key;
  final String? label;

  const StatusModel({this.key, this.label});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      key: json['key'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'label': label};

  @override
  List<Object?> get props => [key, label];
}

class TypeModel extends Equatable {
  final String? key;
  final String? label;

  const TypeModel({this.key, this.label});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      key: json['key'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'label': label};

  @override
  List<Object?> get props => [key, label];
}

class ServiceTypeModel extends Equatable {
  final String? key;
  final String? label;

  const ServiceTypeModel({this.key, this.label});

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      key: json['key'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'label': label};

  @override
  List<Object?> get props => [key, label];
}

class ParticipantModel extends Equatable {
  final String? address;
  final LocationModel? location;
  final String? contactName;
  final String? contactPhone;
  final String? avatar;

  const ParticipantModel({
    this.address,
    this.location,
    this.contactName,
    this.contactPhone,
    this.avatar,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      address: json['address'],
      location: json['location'] != null ? LocationModel.fromJson(json['location']) : null,
      contactName: json['contact_name'],
      contactPhone: json['contact_phone'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'location': location?.toJson(),
      'contact_name': contactName,
      'contact_phone': contactPhone,
      'avatar': avatar,
    };
  }

  @override
  List<Object?> get props => [address, location, contactName, contactPhone, avatar];
}

class LocationModel extends Equatable {
  final double? lat;
  final double? lng;

  const LocationModel({this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  @override
  List<Object?> get props => [lat, lng];
}

class PackageModel extends Equatable {
  final PackageTypeModel? type;
  final String? weight;
  final SizeModel? size;
  final List<String>? images;

  const PackageModel({this.type, this.weight, this.size, this.images});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      type: json['type'] != null ? PackageTypeModel.fromJson(json['type']) : null,
      weight: json['weight']?.toString(),
      size: json['size'] != null ? SizeModel.fromJson(json['size']) : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type?.toJson(),
      'weight': weight,
      'size': size?.toJson(),
      'images': images,
    };
  }

  @override
  List<Object?> get props => [type, weight, size, images];
}

class PackageTypeModel extends Equatable {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameEn;
  final bool? isActive;
  final int? sortOrder;

  const PackageTypeModel({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.isActive,
    this.sortOrder,
  });

  factory PackageTypeModel.fromJson(Map<String, dynamic> json) {
    return PackageTypeModel(
      id: json['id'],
      name: json['name'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      isActive: json['is_active'],
      sortOrder: json['sort_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'name_en': nameEn,
      'is_active': isActive,
      'sort_order': sortOrder,
    };
  }

  @override
  List<Object?> get props => [id, name, nameAr, nameEn, isActive, sortOrder];
}

class SizeModel extends Equatable {
  final String? key;
  final String? label;

  const SizeModel({this.key, this.label});

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      key: json['key'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'label': label};

  @override
  List<Object?> get props => [key, label];
}

class PricingModel extends Equatable {
  final String? driverOfferPrice;
  final String? finalPrice;
  final String? vatAmount;
  final String? platformFee;
  final String? driverEarnings;

  const PricingModel({
    this.driverOfferPrice,
    this.finalPrice,
    this.vatAmount,
    this.platformFee,
    this.driverEarnings,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      driverOfferPrice: json['driver_offer_price']?.toString(),
      finalPrice: json['final_price']?.toString(),
      vatAmount: json['vat_amount']?.toString(),
      platformFee: json['platform_fee']?.toString(),
      driverEarnings: json['driver_earnings']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_offer_price': driverOfferPrice,
      'final_price': finalPrice,
      'vat_amount': vatAmount,
      'platform_fee': platformFee,
      'driver_earnings': driverEarnings,
    };
  }

  @override
  List<Object?> get props => [
        driverOfferPrice,
        finalPrice,
        vatAmount,
        platformFee,
        driverEarnings,
      ];
}

class DriverModel extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? rateing;
  final String? commissionRate;
  final bool? isOnline;
  final LocationModel? currentLocation;
  final String? faceImage;
  final String? numberOfRateing;
  final List<VehicleModel>? vehicles;
  final String? createdAt;
  final String? updatedAt;

  const DriverModel({
    this.id,
    this.name,
    this.phone,
    this.rateing,
    this.numberOfRateing,
    this.commissionRate,
    this.isOnline,
    this.currentLocation,
    this.faceImage,
    this.vehicles,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      rateing: json['rateing']?.toString(),
      numberOfRateing: json['number_of_rateing']?.toString(),
      commissionRate: json['commission_rate']?.toString(),
      isOnline: json['is_online'],
      currentLocation: json['current_location'] != null
          ? LocationModel.fromJson(json['current_location'])
          : null,
      faceImage: json['face_image'],
      vehicles: json['vehicles'] != null
          ? List<VehicleModel>.from(json['vehicles'].map((x) => VehicleModel.fromJson(x)))
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
      'number_of_rateing': numberOfRateing,
      'commission_rate': commissionRate,
      'is_online': isOnline,
      'current_location': currentLocation?.toJson(),
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
        numberOfRateing,
        commissionRate,
        isOnline,
        currentLocation,
        faceImage,
        vehicles,
        createdAt,
        updatedAt,
      ];
}

class VehicleModel extends Equatable {
  final int? id;
  final int? driverId;
  final int? type;
  final String? plateNumber;
  final String? status;
  final String? vehicleSize;
  final bool? isDefault;
  final VehicleImagesModel? images;
  final ExternalVehicleTypeModel? vehicleType;
  final String? createdAt;
  final String? updatedAt;

  const VehicleModel({
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

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      driverId: json['driver_id'],
      type: json['type'],
      plateNumber: json['plate_number'],
      status: json['status'],
      vehicleSize: json['vehicle_size'],
      isDefault: json['is_default'],
      images: json['images'] != null ? VehicleImagesModel.fromJson(json['images']) : null,
      vehicleType: json['vehicle_type'] != null
          ? ExternalVehicleTypeModel.fromJson(json['vehicle_type'])
          : null,
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
      'images': images?.toJson(),
      'vehicle_type': vehicleType?.toJson(),
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

class VehicleImagesModel extends Equatable {
  final String? registration;
  final String? authorization;
  final String? front;
  final String? back;
  final String? left;
  final String? right;
  final String? combined;

  const VehicleImagesModel({
    this.registration,
    this.authorization,
    this.front,
    this.back,
    this.left,
    this.right,
    this.combined,
  });

  factory VehicleImagesModel.fromJson(Map<String, dynamic> json) {
    return VehicleImagesModel(
      registration: json['registration'],
      authorization: json['authorization'],
      front: json['front'],
      back: json['back'],
      left: json['left'],
      right: json['right'],
      combined: json['combined'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registration': registration,
      'authorization': authorization,
      'front': front,
      'back': back,
      'left': left,
      'right': right,
      'combined': combined,
    };
  }

  @override
  List<Object?> get props => [
        registration,
        authorization,
        front,
        back,
        left,
        right,
        combined,
      ];
}

class ExternalVehicleTypeModel extends Equatable {
  final int? id;
  final String? code;
  final String? name;
  final String? nameAr;
  final String? nameEn;
  final String? image;
  final bool? isActive;

  const ExternalVehicleTypeModel({
    this.id,
    this.code,
    this.name,
    this.nameAr,
    this.nameEn,
    this.image,
    this.isActive,
  });

  factory ExternalVehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return ExternalVehicleTypeModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      image: json['image'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'name_ar': nameAr,
      'name_en': nameEn,
      'image': image,
      'is_active': isActive,
    };
  }

  @override
  List<Object?> get props => [id, code, name, nameAr, nameEn, image, isActive];
}

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
  final DriverModel? driver;

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
      offeredPrice: json['offered_price']?.toString(),
      message: json['message'],
      status: json['status'],
      statusLabel: json['status_label'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
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

class OrdersResponseModel extends Equatable {
  final bool? success;
  final List<OrderModel>? data;
  final PaginationDataModel? pagination;

  const OrdersResponseModel({this.success, this.data, this.pagination});

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) {
    return OrdersResponseModel(
      success: json['success'],
      data: json['data'] != null
          ? List<OrderModel>.from(json['data'].map((x) => OrderModel.fromJson(x)))
          : null,
      pagination: json['pagination'] != null
          ? PaginationDataModel.fromJson(json['pagination'])
          : null,
    );
  }

  @override
  List<Object?> get props => [success, data, pagination];
}

class PaginationDataModel extends Equatable {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  const PaginationDataModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory PaginationDataModel.fromJson(Map<String, dynamic> json) {
    return PaginationDataModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, total];
}
