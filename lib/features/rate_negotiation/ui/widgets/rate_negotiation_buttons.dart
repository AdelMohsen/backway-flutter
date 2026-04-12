import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class RateNegotiationButtons extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isLoading;

  const RateNegotiationButtons({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Confirm Button
          DefaultButton(
            borderRadius: BorderRadius.circular(45),
            isLoading: isLoading,
            height: 56,
            text: AppStrings.confirm.tr,
            onPressed: onConfirm,
            textStyle: AppTextStyles.ibmPlexSansSize16w500Primary.copyWith(
              fontSize: 18,

              color: Colors.white,
            ),
            backgroundColor: AppColors.primaryGreenHub,
            textColor: Colors.white,
          ),
          const SizedBox(height: 16),

          // Cancel Button
          DefaultButton(
            height: 56,
            borderRadius: BorderRadius.circular(45),
            text: AppStrings.cancel.tr,
            onPressed: onCancel,
            textStyle: AppTextStyles.ibmPlexSansSize16w500Primary.copyWith(
              fontSize: 18,

              color: AppColors.primaryGreenHub,
            ),
            backgroundColor: Color.fromRGBO(237, 246, 245, 1),
          ),
        ],
      ),
    );
  }
}
