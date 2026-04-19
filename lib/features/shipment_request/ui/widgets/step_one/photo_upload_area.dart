import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class PhotoUploadArea extends StatelessWidget {
  const PhotoUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: const RoundedRectDottedBorderOptions(
        color: Color.fromRGBO(226, 232, 240, 1.0),
        strokeWidth: 1.0,
        dashPattern: [6.0, 3.0],
        radius: Radius.circular(20.0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              SvgImages.docs,
              width: 32,
              height: 32,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(148, 163, 184, 1),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.uploadPhotos.tr,
              style: Styles.urbanistSize14w400White.copyWith(
                color: const Color.fromRGBO(148, 163, 184, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
