import 'package:equatable/equatable.dart';

class RegionResponseModel extends Equatable {
  const RegionResponseModel({required this.success, required this.data});

  final bool success;
  final List<RegionModel> data;

  factory RegionResponseModel.fromJson(Map<String, dynamic> json) {
    return RegionResponseModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List?)
              ?.map((e) => RegionModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class RegionModel extends Equatable {
  const RegionModel({
    required this.id,
    required this.name,
    required this.code,
    required this.population,
    required this.capitalCityId,
  });

  final int id;
  final String name;
  final String? code;
  final int? population;
  final int? capitalCityId;

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'],
      population: json['population'],
      capitalCityId: json['capital_city_id'],
    );
  }

  @override
  List<Object?> get props => [id, code, name, population, capitalCityId];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'population': population,
      'capital_city_id': capitalCityId,
    };
  }
}
