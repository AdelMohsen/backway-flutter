import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ShipmentRequestStepper extends StatelessWidget {
  final int currentStep;

  const ShipmentRequestStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          _buildStep(0, AppStrings.step1.tr),
          const SizedBox(width: 12),
          _buildStep(1, AppStrings.step2.tr),
          const SizedBox(width: 12),
          _buildStep(2, AppStrings.step3.tr),
        ],
      ),
    );
  }

  Widget _buildStep(int index, String label) {
    bool isActive = index == currentStep;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4.55,
            decoration: BoxDecoration(
              color: isActive
                  ? ColorsApp.KorangePrimary
                  : const Color.fromRGBO(243, 244, 246, 1),

              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Styles.urbanistSize12w600Orange.copyWith(
              color: isActive
                  ? ColorsApp.KorangePrimary
                  : const Color.fromRGBO(107, 114, 128, 1),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
