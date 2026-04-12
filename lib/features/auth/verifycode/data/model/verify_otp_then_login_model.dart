import 'package:equatable/equatable.dart';

import 'user_data_model.dart';

class VerifyOtpThenLoginModel extends Equatable {
  final bool success;
  final String message;
  final UserDataModel user;
  final String token;

  const VerifyOtpThenLoginModel({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory VerifyOtpThenLoginModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpThenLoginModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        user: UserDataModel.fromJson(json['data']['user'] ?? {}),
        token: json['data']['token'] ?? '',
      );

  @override
  List<Object?> get props => [success, message, user, token];
}
