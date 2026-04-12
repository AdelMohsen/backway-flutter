import 'package:equatable/equatable.dart';

class CityResponseModel extends Equatable {
  const CityResponseModel({required this.success, required this.data});

  final bool success;
  final List<CityModel> data;

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return CityResponseModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List?)?.map((e) => CityModel.fromJson(e)).toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class CityModel extends Equatable {
  const CityModel({
    required this.id,
    required this.regionId,
    required this.name,
  });

  final int id;
  final int regionId;
  final String name;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? 0,
      regionId: json['region_id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, regionId, name];

  Map<String, dynamic> toJson() {
    return {'id': id, 'region_id': regionId, 'name': name};
  }
}
