import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ComplaintSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final bool isLoading;

  const ComplaintSubmitButton({
    super.key,
    required this.onPressed,
    this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primaryGreenHub,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text ?? AppStrings.submit.tr,
                  style: AppTextStyles.ibmPlexSansSize18w600White,
                ),
        ),
      ),
    );
  }
}
