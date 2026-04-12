import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OfferActionButtons extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const OfferActionButtons({
    super.key,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onApprove,
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(237, 246, 245, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  AppStrings.approve.tr,
                  style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                    color: AppColors.primaryGreenHub,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: GestureDetector(
            onTap: onReject,
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 240, 246, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  AppStrings.reject.tr,
                  style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                    color: const Color.fromRGBO(244, 67, 54, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
