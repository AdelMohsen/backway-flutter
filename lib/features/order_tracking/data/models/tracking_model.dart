import 'package:equatable/equatable.dart';

class TrackingModel extends Equatable {
  final TrackingOrder order;
  final TrackingLocation? driverLocation;
  final bool driverOnline;

  const TrackingModel({
    required this.order,
    this.driverLocation,
    required this.driverOnline,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      order: TrackingOrder.fromJson(json['data']?['order'] ?? {}),
      driverLocation: json['data']?['driver_location'] != null
          ? TrackingLocation.fromJson(json['data']?['driver_location'])
          : null,
      driverOnline: json['data']?['driver_online'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'order': order.toJson(),
        'driver_location': driverLocation?.toJson(),
        'driver_online': driverOnline,
      }
    };
  }

  @override
  List<Object?> get props => [order, driverLocation, driverOnline];
}

class TrackingOrder extends Equatable {
  final int id;
  final String orderNumber;
  final TrackingKeyLabelable status;
  final TrackingKeyLabelable type;
  final TrackingKeyLabelable serviceType;
  final int vehiclesCount;
  final String? notes;
  final TrackingPoint pickup;
  final TrackingPoint delivery;
  final TrackingPackage package;
  final TrackingPricing pricing;
  final String? scheduledAt;
  final String? acceptedAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final String? cancelledAt;
  final TrackingDriver? driver;
  final String? createdAt;
  final String? updatedAt;

  const TrackingOrder({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.type,
    required this.serviceType,
    required this.vehiclesCount,
    this.notes,
    required this.pickup,
    required this.delivery,
    required this.package,
    required this.pricing,
    this.scheduledAt,
    this.acceptedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
    this.driver,
    this.createdAt,
    this.updatedAt,
  });

  factory TrackingOrder.fromJson(Map<String, dynamic> json) {
    return TrackingOrder(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      status: TrackingKeyLabelable.fromJson(json['status'] ?? {}),
      type: TrackingKeyLabelable.fromJson(json['type'] ?? {}),
      serviceType: TrackingKeyLabelable.fromJson(json['service_type'] ?? {}),
      vehiclesCount: json['vehicles_count'] ?? 0,
      notes: json['notes'],
      pickup: TrackingPoint.fromJson(json['pickup'] ?? {}),
      delivery: TrackingPoint.fromJson(json['delivery'] ?? {}),
      package: TrackingPackage.fromJson(json['package'] ?? {}),
      pricing: TrackingPricing.fromJson(json['pricing'] ?? {}),
      scheduledAt: json['scheduled_at'],
      acceptedAt: json['accepted_at'],
      pickedUpAt: json['picked_up_at'],
      deliveredAt: json['delivered_at'],
      cancelledAt: json['cancelled_at'],
      driver: json['driver'] != null ? TrackingDriver.fromJson(json['driver']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'status': status.toJson(),
      'type': type.toJson(),
      'service_type': serviceType.toJson(),
      'vehicles_count': vehiclesCount,
      'notes': notes,
      'pickup': pickup.toJson(),
      'delivery': delivery.toJson(),
      'package': package.toJson(),
      'pricing': pricing.toJson(),
      'scheduled_at': scheduledAt,
      'accepted_at': acceptedAt,
      'picked_up_at': pickedUpAt,
      'delivered_at': deliveredAt,
      'cancelled_at': cancelledAt,
      'driver': driver?.toJson(),
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
        createdAt,
        updatedAt,
      ];
}

class TrackingKeyLabelable extends Equatable {
  final String key;
  final String label;

  const TrackingKeyLabelable({required this.key, required this.label});

  factory TrackingKeyLabelable.fromJson(Map<String, dynamic> json) {
    return TrackingKeyLabelable(
      key: json['key'] ?? '',
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
    };
  }

  @override
  List<Object?> get props => [key, label];
}

class TrackingPoint extends Equatable {
  final String? address;
  final TrackingLocation? location;
  final String? contactName;
  final String? contactPhone;
  final String? avatar;

  const TrackingPoint({
    this.address,
    this.location,
    this.contactName,
    this.contactPhone,
    this.avatar,
  });

  factory TrackingPoint.fromJson(Map<String, dynamic> json) {
    return TrackingPoint(
      address: json['address'],
      location: json['location'] != null
          ? TrackingLocation.fromJson(json['location'])
          : null,
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
  List<Object?> get props =>
      [address, location, contactName, contactPhone, avatar];
}

class TrackingLocation extends Equatable {
  final double lat;
  final double lng;

  const TrackingLocation({required this.lat, required this.lng});

  factory TrackingLocation.fromJson(Map<String, dynamic> json) {
    return TrackingLocation(
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  List<Object?> get props => [lat, lng];
}

class TrackingPackage extends Equatable {
  final TrackingPackageType? type;
  final String? weight;
  final TrackingKeyLabelable? size;
  final List<String> images;

  const TrackingPackage({
    this.type,
    this.weight,
    this.size,
    required this.images,
  });

  factory TrackingPackage.fromJson(Map<String, dynamic> json) {
    return TrackingPackage(
      type: json['type'] != null
          ? TrackingPackageType.fromJson(json['type'])
          : null,
      weight: json['weight']?.toString(),
      size: json['size'] != null
          ? TrackingKeyLabelable.fromJson(json['size'])
          : null,
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ??
          [],
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

class TrackingPackageType extends Equatable {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final bool isActive;
  final int sortOrder;

  const TrackingPackageType({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.isActive,
    required this.sortOrder,
  });

  factory TrackingPackageType.fromJson(Map<String, dynamic> json) {
    return TrackingPackageType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
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
  List<Object?> get props =>
      [id, name, nameAr, nameEn, isActive, sortOrder];
}

class TrackingPricing extends Equatable {
  final String? driverOfferPrice;
  final String finalPrice;
  final String vatAmount;
  final String platformFee;
  final String driverEarnings;

  const TrackingPricing({
    this.driverOfferPrice,
    required this.finalPrice,
    required this.vatAmount,
    required this.platformFee,
    required this.driverEarnings,
  });

  factory TrackingPricing.fromJson(Map<String, dynamic> json) {
    return TrackingPricing(
      driverOfferPrice: json['driver_offer_price']?.toString(),
      finalPrice: json['final_price']?.toString() ?? '0.00',
      vatAmount: json['vat_amount']?.toString() ?? '0.00',
      platformFee: json['platform_fee']?.toString() ?? '0.00',
      driverEarnings: json['driver_earnings']?.toString() ?? '0.00',
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
  List<Object?> get props =>
      [driverOfferPrice, finalPrice, vatAmount, platformFee, driverEarnings];
}

class TrackingDriver extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String rateing;
  final String numberOfRateing;
  final String commissionRate;
  final bool isOnline;
  final TrackingLocation? currentLocation;
  final String? faceImage;
  final List<TrackingVehicle> vehicles;

  const TrackingDriver({
    required this.id,
    required this.name,
    required this.phone,
    required this.rateing,
    required this.numberOfRateing,
    required this.commissionRate,
    required this.isOnline,
    this.currentLocation,
    this.faceImage,
    required this.vehicles,
  });

  factory TrackingDriver.fromJson(Map<String, dynamic> json) {
    return TrackingDriver(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      rateing: json['rateing']?.toString() ?? '0.0',
      numberOfRateing: json['number_of_rateing']?.toString() ?? '0',
      commissionRate: json['commission_rate']?.toString() ?? '0.00',
      isOnline: json['is_online'] ?? false,
      currentLocation: json['current_location'] != null
          ? TrackingLocation.fromJson(json['current_location'])
          : null,
      faceImage: json['face_image'],
      vehicles: (json['vehicles'] as List?)
              ?.map((e) => TrackingVehicle.fromJson(e))
              .toList() ??
          [],
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
      'vehicles': vehicles.map((e) => e.toJson()).toList(),
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
      ];
}

class TrackingVehicle extends Equatable {
  final int id;
  final int driverId;
  final int type;
  final String plateNumber;
  final String status;
  final String vehicleSize;
  final bool isDefault;
  final TrackingVehicleImages images;
  final TrackingVehicleType? vehicleType;

  const TrackingVehicle({
    required this.id,
    required this.driverId,
    required this.type,
    required this.plateNumber,
    required this.status,
    required this.vehicleSize,
    required this.isDefault,
    required this.images,
    this.vehicleType,
  });

  factory TrackingVehicle.fromJson(Map<String, dynamic> json) {
    return TrackingVehicle(
      id: json['id'] ?? 0,
      driverId: json['driver_id'] ?? 0,
      type: json['type'] ?? 0,
      plateNumber: json['plate_number'] ?? '',
      status: json['status'] ?? '',
      vehicleSize: json['vehicle_size'] ?? '',
      isDefault: json['is_default'] ?? false,
      images: TrackingVehicleImages.fromJson(json['images'] ?? {}),
      vehicleType: json['vehicle_type'] != null
          ? TrackingVehicleType.fromJson(json['vehicle_type'])
          : null,
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
      'images': images.toJson(),
      'vehicle_type': vehicleType?.toJson(),
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
      ];
}

class TrackingVehicleImages extends Equatable {
  final String? registration;
  final String? authorization;
  final String? front;
  final String? back;
  final String? left;
  final String? right;
  final String? combined;

  const TrackingVehicleImages({
    this.registration,
    this.authorization,
    this.front,
    this.back,
    this.left,
    this.right,
    this.combined,
  });

  factory TrackingVehicleImages.fromJson(Map<String, dynamic> json) {
    return TrackingVehicleImages(
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

class TrackingVehicleType extends Equatable {
  final int id;
  final String code;
  final String name;
  final String nameAr;
  final String nameEn;
  final String? image;
  final bool isActive;

  const TrackingVehicleType({
    required this.id,
    required this.code,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    this.image,
    required this.isActive,
  });

  factory TrackingVehicleType.fromJson(Map<String, dynamic> json) {
    return TrackingVehicleType(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      image: json['image'],
      isActive: json['is_active'] ?? false,
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
  List<Object?> get props =>
      [id, code, name, nameAr, nameEn, image, isActive];
}
