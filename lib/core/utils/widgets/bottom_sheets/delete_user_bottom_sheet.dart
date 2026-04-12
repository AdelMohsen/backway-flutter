import 'package:flutter/material.dart';
import 'package:greenhub/core/app_core.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';

class DeleteUserBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? retryButtonText;
  final String? backToLoginText;
  final VoidCallback? onRetry;
  final VoidCallback? onBackToLogin;

  const DeleteUserBottomSheet({
    Key? key,
    required this.title,
    this.subtitle,
    this.retryButtonText,
    this.backToLoginText,
    this.onRetry,
    this.onBackToLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 60,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Error Icon with decorative elements
          Stack(
            alignment: Alignment.center,
            children: [Image.asset(AppImages.failer)],
          ),

          const SizedBox(height: 24),

          // Title with emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              Flexible(
                child: MainText(
                  text: title,
                  style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
                    color: const Color(0xFF333333),
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 4),

              const Text('🚫', style: TextStyle(fontSize: 20)),
            ],
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 12),
            MainText(
              text: subtitle!,
              style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
                color: const Color.fromRGBO(146, 146, 146, 1),
              ),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 30),

          // Retry Button
          if (retryButtonText != null && onRetry != null)
            DefaultButton(
              backgroundColor: Color.fromRGBO(255, 76, 76, 1),
              width: 298,

              borderRadiusValue: 44,
              text: retryButtonText!,
              onPressed: onRetry,
              height: 56,
              borderRadius: BorderRadius.circular(44),
              textStyle: AppTextStyles.ibmPlexSansSize18w700Primary.copyWith(
                color: AppColors.kWhite,
              ),
            ),

          if (retryButtonText != null && backToLoginText != null)
            const SizedBox(height: 12),

          // Back to Login Button
          if (backToLoginText != null && onBackToLogin != null)
            DefaultButton(
              backgroundColor: Color.fromRGBO(255, 76, 76, 0.06),
              width: 298,
              borderRadiusValue: 44,
              text: AppStrings.back.tr,
              onPressed: onBackToLogin,
              height: 56,
              borderRadius: BorderRadius.circular(44),
              textStyle: AppTextStyles.ibmPlexSansSize18w700Primary.copyWith(
                color: AppColors.kRed,
              ),
            ),

          const SizedBox(height: 5),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? retryButtonText,
    String? backToLoginText,
    VoidCallback? onRetry,
    VoidCallback? onBackToLogin,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DeleteUserBottomSheet(
        title: title,
        subtitle: subtitle,
        retryButtonText: retryButtonText,
        backToLoginText: backToLoginText,
        onRetry: onRetry,
        onBackToLogin: onBackToLogin,
      ),
    );
  }
}
