import 'package:equatable/equatable.dart';

class DeleteAccountModel extends Equatable {
  final bool? success;
  final String? message;

  const DeleteAccountModel({this.success, this.message});

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel(
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
