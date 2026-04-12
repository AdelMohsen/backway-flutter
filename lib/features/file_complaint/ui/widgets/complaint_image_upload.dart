import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'dart:io';

class ComplaintImageUpload extends StatelessWidget {
  final List<File> selectedImages;
  final VoidCallback onTap;
  final String? title;
  final String? subtitle;

  const ComplaintImageUpload({
    super.key,
    required this.selectedImages,
    required this.onTap,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: selectedImages.isEmpty
            ? _buildUploadPlaceholder(context)
            : _buildSelectedImages(),
      ),
    );
  }

  Widget _buildUploadPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 22),
          width: MediaQuery.of(context).size.width * 0.750,

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(236, 236, 236, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SvgPicture.asset(AppSvg.uploadFile),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
                    color: Color.fromRGBO(34, 34, 34, 0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(text: AppStrings.uploadText.tr),
                    TextSpan(
                      text: AppStrings.imagesText.tr,
                      style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
                        color: AppColors.kBlack,
                      ),
                    ),
                    TextSpan(text: AppStrings.hereText.tr),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle ?? AppStrings.imageFormatsSubtitle.tr,
                style: AppTextStyles.ibmPlexSansSize10w400Hint.copyWith(
                  color: Color.fromRGBO(163, 163, 163, 1),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSelectedImages() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        ...selectedImages.map((image) => _buildImageThumbnail(image)),
        _buildAddMoreButton(),
      ],
    );
  }

  Widget _buildImageThumbnail(File image) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryGreenHub, width: 1),
      ),
      child: Icon(Icons.add, color: AppColors.primaryGreenHub, size: 24),
    );
  }
}
