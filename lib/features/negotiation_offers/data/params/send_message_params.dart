import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class SendMessageParams extends Equatable {
  final String message;
  final String type;
  final File? attachment;

  const SendMessageParams({
    required this.message,
    this.type = 'text',
    this.attachment,
  });

  Future<Map<String, dynamic>> returnedMap() async {
    return {
      'message': message,
      'type': type,
      if (attachment != null)
        'attachment': await MultipartFile.fromFile(
          attachment!.path,
          filename: attachment!.path.split(Platform.pathSeparator).last,
        ),
    };
  }

  @override
  List<Object?> get props => [message, type, attachment];
}
