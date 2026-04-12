import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final bool success;
  final String message;
  final int expiresIn;

  const LoginModel({
    required this.success,
    required this.message,
    required this.expiresIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    expiresIn: json['expires_in'] ?? 0,
  );

  @override
  List<Object?> get props => [success, message, expiresIn];
}
