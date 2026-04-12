import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/single_container_widget.dart';

class ImageUploadSectionWidget extends StatelessWidget {
  final VoidCallback? onUploadTap;
  final List<File> selectedImages;
  final Function(int)? onRemoveImage;

  const ImageUploadSectionWidget({
    Key? key,
    this.onUploadTap,
    this.selectedImages = const [],
    this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleContainerWidget(
      title: AppStrings.uploadShipmentImages.tr,
      contentChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromRGBO(230, 230, 230, 1),
                width: 1,
              ),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                // Render selected images
                ...List.generate(selectedImages.length, (index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(selectedImages[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -6,
                        right: -6,
                        child: GestureDetector(
                          onTap: () => onRemoveImage?.call(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                // Add button / Placeholder
                if (selectedImages.length < 8)
                  GestureDetector(
                    onTap: onUploadTap,
                    child: Container(
                      width: selectedImages.isEmpty ? double.infinity : 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryGreenHub.withOpacity(0.3),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: selectedImages.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.docss, height: 32),
                                const SizedBox(height: 8),
                                Text(
                                  AppStrings.uploadImageHere.tr,
                                  style: AppTextStyles
                                      .ibmPlexSansSize12w500Title
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            )
                          : Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.primaryGreenHub,
                              size: 28,
                            ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              AppStrings.supportedFormats.tr,
              style: AppTextStyles.ibmPlexSansSize10w400Grey,
            ),
          ),
        ],
      ),
    );
  }
}
