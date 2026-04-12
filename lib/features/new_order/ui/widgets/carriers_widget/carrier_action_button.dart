import 'package:flutter/material.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../../../../../core/theme/colors/styles.dart';

/// Action buttons row (Details, Reject, Accept)
class CarrierActionButtons extends StatelessWidget {
  const CarrierActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, end: 4),
      child: Row(
        children: [
          Expanded(
            flex: 150,
            child: CarrierActionButton(
              text: AppStrings.details.tr,
              backgroundColor: Color.fromRGBO(237, 246, 245, 1),
              textColor: AppColors.primaryGreenHub,
              onTap: () {
                CustomNavigator.push(Routes.AVALABLE_VECHILE);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 120,
            child: CarrierActionButton(
              text: AppStrings.reject.tr,
              backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
              textColor: const Color.fromRGBO(244, 67, 54, 1),
              onTap: () {
                CustomNavigator.push(Routes.AVALABLE_VECHILE);
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 150,
            child: CarrierActionButton(
              text: AppStrings.approve.tr,
              backgroundColor: const Color.fromRGBO(237, 246, 245, 1),
              textColor: AppColors.primaryGreenHub,
              onTap: () {
                CustomNavigator.push(Routes.AVALABLE_VECHILE);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual action button widget
class CarrierActionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const CarrierActionButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
