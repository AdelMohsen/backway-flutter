import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

class CancellationReasonBottomSheet extends StatelessWidget {
  const CancellationReasonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Text(
            AppStrings.cancellationReason.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: ColorsApp.kPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppStrings.cancelShipmentSubtitle.tr,
              textAlign: TextAlign.center,
              style: Styles.urbanistSize14w500Orange.copyWith(
                color: const Color.fromRGBO(107, 114, 128, 1),
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 32),
          DefaultFormField(
            hintText: AppStrings.writeTheReason.tr,
            maxLines: 4,
            fillColor: const Color.fromRGBO(249, 250, 251, 1),
            borderColor: Colors.transparent,
            enabledBorderColor: Colors.transparent,
            foucsBorderColor: Colors.transparent,
            borderRadious: 16,
            contentPadding: const EdgeInsets.all(16),
            textAlign: TextAlign.start,
            hintStyle: Styles.urbanistSize14w500Orange.copyWith(
              color: const Color.fromRGBO(156, 163, 175, 1),
            ),
          ),
          const SizedBox(height: 32),
          DefaultButton(
            onPressed: () {
              CustomNavigator.pop();
            },
            text: AppStrings.send.tr,
            backgroundColor: ColorsApp.kPrimary,
            textStyle: Styles.urbanistSize14w600White.copyWith(
              color: Colors.white,
            ),
            borderRadiusValue: 45,
            height: 52,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
