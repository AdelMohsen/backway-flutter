import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../utility.dart';

class FileUploader {
  Future<File?> pickFile({List<String>? allowedExtensions}) async {
    try {
      // Open file picker with normalized extensions
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions?.map((e) => e).toList(),
        allowMultiple: false,
        withData: true,
        withReadStream: true,
      );

      // Check if the user selected a file
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      } else {
        // No file selected
        return null;
      }
    } catch (e) {
      // Handle exceptions
      cprint('Error picking file: $e');
      return null;
    }
  }
}
