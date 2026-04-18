import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';

class RateDriverBottomButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onMaybeLater;

  const RateDriverBottomButtons({
    super.key,
    required this.onSubmit,
    required this.onMaybeLater,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultButton(
            onPressed: onSubmit,
            text: "Submit Review",
            backgroundColor: ColorsApp.kPrimary,
            textStyle: Styles.urbanistSize14w700White,
            borderRadiusValue: 45,
            height: 48,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onMaybeLater,
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 250, 251, 1),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Text(
                "Maybe Later",
                style: Styles.urbanistSize14w600Orange.copyWith(
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
