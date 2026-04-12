import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helpers/permissions.dart';
import '../../../navigation/custom_navigation.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../utility.dart';

abstract class ImagePickerHelper {
  static showOption({ValueChanged<File?>? onGet}) {
    showDialog(
      context: CustomNavigator.context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text(AppStrings.selectImageSource.tr)),
          actions: [
            CupertinoDialogAction(
                child: Text(AppStrings.gallery.tr),
                onPressed: () => openGallery(onGet: onGet)),
            CupertinoDialogAction(
                child: Text(AppStrings.camera.tr),
                onPressed: () => openCamera(onGet: onGet)),
          ],
        );
      },
    );
  }

  static showMultiOption({
    ValueChanged<File?>? onGetSingle,
    ValueChanged<List<File>>? onGetMultiple,
    bool allowDuplicates = false,
    int imageLimit = 5,
    List<File>? selectedImages,
  }) {
    showDialog(
      context: CustomNavigator.context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text('AppStrings.selectImageSource.tr')),
          actions: [
            CupertinoDialogAction(
                child: Text('AppStrings.gallery.tr'),
                onPressed: () {
                  if (onGetMultiple != null) {
                    openMultiGallery(
                      onGetMultiple: onGetMultiple,
                      allowDuplicates: allowDuplicates,
                      imageLimit: imageLimit,
                      selectedImages: selectedImages,
                    );
                  }
                }),
            CupertinoDialogAction(
                child: Text('AppStrings.camera.tr'),
                onPressed: () {
                  if (onGetSingle != null) {
                    openCamera(onGet: onGetSingle);
                  }
                }),
          ],
        );
      },
    );
  }

  static openGallery({ValueChanged<File>? onGet}) async {
    try {
      CustomNavigator.pop();
      var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image != null && onGet != null) {
        cprint('Gallery image selected: ${image.path}');
        onGet.call(File(image.path));
      } else {
        cprint('Gallery selection cancelled or failed');
      }
    } catch (e) {
      cprint('Error picking image from gallery: $e');
      // Optionally show error message to user
    }
  }

  static openCamera({ValueChanged<File>? onGet}) async {
    try {
      CustomNavigator.pop();

      // Check camera permission before attempting to use camera
      bool hasPermission = await PermissionHandler.checkCameraPermission();
      if (!hasPermission) {
        cprint('Camera permission denied');
        return;
      }

      var image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (image != null && onGet != null) {
        cprint('Camera image captured: ${image.path}');
        onGet.call(File(image.path));
      } else {
        cprint('Camera capture cancelled or failed');
      }
    } catch (e) {
      cprint('Error capturing image from camera: $e');
      // Optionally show error message to user
    }
  }

  /// Opens gallery to pick multiple images with optional configuration
  /// [onGetMultiple] - Callback for handling the selected images
  /// [selectedImages] - Optional list of already selected images to mark as selected when reopening
  /// [allowDuplicates] - Whether to allow duplicate images to be added (defaults to false)
  /// [imageLimit] - Maximum number of images that can be selected (defaults to 5)
  static openMultiGallery({
    required ValueChanged<List<File>> onGetMultiple,
    List<File>? selectedImages,
    bool allowDuplicates = false,
    int imageLimit = 5,
  }) async {
    try {
      // Pop the dialog if it was called from showOption
      CustomNavigator.pop();

      // Use pickMultiImage to select multiple images
      List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
        imageQuality: 100,
        limit: imageLimit,
      );

      // If no images were selected
      if (pickedImages.isEmpty) {
        // If there are already selected images, return them to maintain the selection
        if (selectedImages != null && selectedImages.isNotEmpty) {
          onGetMultiple.call(selectedImages);
        } else {
          // Return an empty list if nothing was selected and no previous selection exists
          onGetMultiple.call([]);
        }
        return;
      }

      // Convert XFile list to File list
      List<File> selectedFiles =
          pickedImages.map((xFile) => File(xFile.path)).toList();

      // If there are previously selected images and we need to handle them
      if (selectedImages != null && selectedImages.isNotEmpty) {
        if (allowDuplicates) {
          // If duplicates are allowed, simply add the new images to the existing ones
          selectedFiles = [...selectedImages, ...selectedFiles];
        } else {
          // Create a new list to hold unique files
          List<File> uniqueFiles = [];

          // Keep track of file names we've already seen
          Set<String> fileNamesSeen = {};
          Set<String> pathsSeen = {};

          // First add all existing selected images to our unique list
          for (var file in selectedImages) {
            String fileName = file.path.split('/').last.toLowerCase();
            fileNamesSeen.add(fileName);
            pathsSeen.add(file.path);
            uniqueFiles.add(file);
          }

          // Then only add new images if they aren't duplicates
          for (var file in selectedFiles) {
            String fileName = file.path.split('/').last.toLowerCase();
            String path = file.path;

            // Check if this file name or path was already seen
            if (!fileNamesSeen.contains(fileName) &&
                !pathsSeen.contains(path)) {
              fileNamesSeen.add(fileName);
              pathsSeen.add(path);
              uniqueFiles.add(file);
            }
          }

          // Replace selectedFiles with our uniqueFiles list
          selectedFiles = uniqueFiles;

          // Debug log how many images we have after deduplication
          cprint('After deduplication: ${selectedFiles.length} unique images');
        }
      }

      // Enforce image limit on the final array
      if (selectedFiles.length > imageLimit) {
        selectedFiles = selectedFiles.sublist(0, imageLimit);
        cprint('Enforcing limit: Trimmed to $imageLimit images');
      }

      cprint('Final selection: ${selectedFiles.length} images');
      onGetMultiple.call(selectedFiles);
    } catch (e) {
      cprint('Error picking multiple images from gallery: $e');
      // Return existing selection or empty list on error
      if (selectedImages != null && selectedImages.isNotEmpty) {
        onGetMultiple.call(selectedImages);
      } else {
        onGetMultiple.call([]);
      }
    }
  }
}
