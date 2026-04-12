import 'package:equatable/equatable.dart';

class AcceptNegotiationModel extends Equatable {
  final bool? success;
  final String? message;

  const AcceptNegotiationModel({
    this.success,
    this.message,
  });

  factory AcceptNegotiationModel.fromJson(Map<String, dynamic> json) {
    return AcceptNegotiationModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }

  @override
  List<Object?> get props => [success, message];
}
