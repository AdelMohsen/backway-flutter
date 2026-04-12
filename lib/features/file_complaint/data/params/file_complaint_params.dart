import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class FileComplaintParams extends Equatable {
  final String title;
  final String details;
  final File? image;

  const FileComplaintParams({
    required this.title,
    required this.details,
    this.image,
  });

  Future<Map<String, dynamic>> returnedMap() async {
    return {
      'title': title,
      'details': details,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
    }..removeWhere((key, value) => value == null || value == '');
  }

  @override
  List<Object?> get props => [title, details, image];
}
