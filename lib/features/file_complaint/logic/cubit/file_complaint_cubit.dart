import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../data/params/file_complaint_params.dart';
import '../../data/repository/file_complaint_repo.dart';
import '../state/file_complaint_state.dart';

class FileComplaintCubit extends Cubit<FileComplaintState> {
  FileComplaintCubit() : super(FileComplaintInitial());

  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final File file = File(image.path);
      final int sizeInBytes = await file.length();
      final double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 3) {
        emit(
          FileComplaintError(
            ErrorEntity(
              statusCode: -1,
              message: AppStrings
                  .imageSizeTooBig, // .tr will be handled in UI or here if needed
              errors: [],
            ),
          ),
        );
        return;
      }

      selectedImages.clear(); // Case for single image as per requirements
      selectedImages.add(file);
      emit(FileComplaintImagePicked(DateTime.now())); // Refresh UI
    }
  }

  Future<void> submitComplaint() async {
    if (!formKey.currentState!.validate()) return;

    emit(FileComplaintLoading());
 
    final params = FileComplaintParams(
      title: titleController.text,
      details: detailsController.text,
      image: selectedImages.isNotEmpty ? selectedImages.first : null,
    );

    final result = await FileComplaintRepo.fileComplaint(params);

    result.fold(
      (error) => emit(FileComplaintError(error)),
      (response) => emit(FileComplaintSuccess(response)),
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    detailsController.dispose();
    return super.close();
  }
}
