import 'package:equatable/equatable.dart';

class OffersModel extends Equatable {
  final bool success;
  final List<String> data;

  const OffersModel({required this.success, required this.data});

  factory OffersModel.fromJson(Map<String, dynamic> json) {
    return OffersModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? List<String>.from(json['data']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data};
  }

  @override
  List<Object?> get props => [success, data];
}
