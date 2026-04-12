import 'package:equatable/equatable.dart';

class LogoutModel extends Equatable {
  final bool? success;
  final String? message;

  const LogoutModel({this.success, this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message};
  }

  @override
  List<Object?> get props => [success, message];
}
