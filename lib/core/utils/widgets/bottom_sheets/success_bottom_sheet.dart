import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onDismiss;

  const SuccessBottomSheet({
    Key? key,
    required this.title,
    this.subtitle,
    this.onDismiss,
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

          // Success Icon with decorative elements
          Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Image.asset(AppImages.success),
            ],
          ),

          const SizedBox(height: 24),

          // Title with emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: MainText(
                  text: title,
                  style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
                    color: const Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text('🎉 ', style: TextStyle(fontSize: 24)),
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

          const SizedBox(height: 32),

          // Action Button
          DefaultButton(
            width: double.infinity,
            borderRadiusValue: 44,
            text: mainAppBloc.isArabic
                ? "اكمل"
                : "Continue", // Or a suitable localized string
            onPressed: () {
              Navigator.pop(context);
            },
            height: 56,
            borderRadius: BorderRadius.circular(44),
            textStyle: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: AppColors.kWhite,
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    VoidCallback? onDismiss,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PopScope(
        canPop: false,
        child: SuccessBottomSheet(
          title: title,
          subtitle: subtitle,
          onDismiss: onDismiss,
        ),
      ),
    ).then((_) {
      if (onDismiss != null) onDismiss();
    });
  }
}
