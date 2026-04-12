import 'package:equatable/equatable.dart';

class PackageTypeModel extends Equatable {
  final int id;
  final String name;

  const PackageTypeModel({required this.id, required this.name});

  factory PackageTypeModel.fromJson(Map<String, dynamic> json) {
    return PackageTypeModel(id: json['id'], name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  List<Object?> get props => [id, name];
}
