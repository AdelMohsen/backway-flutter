import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final bool success;
  final String message;
  final int userId;
  final String status;

  const RegisterModel({
    required this.success,
    required this.message,
    required this.userId,
    required this.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    userId: json['data']?['user_id'] ?? 0,
    status: json['data']?['status'] ?? '',
  );

  @override
  List<Object?> get props => [success, message, userId, status];
}
