import 'package:equatable/equatable.dart';

class RejectNegotiationModel extends Equatable {
  final bool? success;
  final String? message;

  const RejectNegotiationModel({
    this.success,
    this.message,
  });

  factory RejectNegotiationModel.fromJson(Map<String, dynamic> json) {
    return RejectNegotiationModel(
      success: json['success'],
      message: json['message'],
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
