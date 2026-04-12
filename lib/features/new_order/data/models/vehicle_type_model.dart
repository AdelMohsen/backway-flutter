import 'package:equatable/equatable.dart';

class VehicleTypeModel extends Equatable {
  final int id;
  final String code;
  final String name;
  final String image;

  const VehicleTypeModel({
    required this.id,
    required this.code,
    required this.name,
    required this.image,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: json['id'],
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name, 'image': image};
  }

  @override
  List<Object?> get props => [id, code, name, image];
}
