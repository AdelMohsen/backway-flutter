import 'package:equatable/equatable.dart';

class EditProfileModel extends Equatable {
  final bool success;
  final String message;
  final int id;
  final String name;
  final String phone;
  final String email;
  final String gender;

  const EditProfileModel({
    required this.success,
    required this.message,
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        id: json['data']?['id'] ?? 0,
        name: json['data']?['name'] ?? '',
        phone: json['data']?['phone'] ?? '',
        email: json['data']?['email'] ?? '',
        gender: json['data']?['gender'] ?? '',
      );

  @override
  List<Object?> get props => [success, message, id, name, phone, email, gender];
}
