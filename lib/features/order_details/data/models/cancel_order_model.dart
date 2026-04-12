import 'package:equatable/equatable.dart';

class CancelOrderResponseModel extends Equatable {
  final bool? success;
  final String? message;

  const CancelOrderResponseModel({
    this.success,
    this.message,
  });

  factory CancelOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CancelOrderResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
    };
  }

  @override
  List<Object?> get props => [success, message];
}
