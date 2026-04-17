import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/shipmet_details/ui/widgets/cancellation_reason_bottom_sheet.dart';

class CancelShipmentBottomSheet extends StatelessWidget {
  const CancelShipmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
          SvgPicture.asset(SvgImages.cancel, width: 80, height: 80),
          const SizedBox(height: 24),
          Text(
            AppStrings.cancelShipment.tr,
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
          const SizedBox(height: 52),
          DefaultButton(
            onPressed: () {
              _showCancelBottomSheet(context);
            },
            text: AppStrings.yesCancelShipment.tr,
            backgroundColor: const Color.fromRGBO(254, 226, 226, 1),
            textStyle: Styles.urbanistSize14w600White.copyWith(
              color: const Color.fromRGBO(185, 28, 28, 1),
            ),
            borderRadiusValue: 45,
            height: 56,
          ),
          const SizedBox(height: 12),
          DefaultButton(
            onPressed: () => CustomNavigator.pop(),
            text: AppStrings.noCancel.tr,
            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
            textStyle: Styles.urbanistSize14w600White.copyWith(
              color: const Color.fromRGBO(75, 85, 99, 1),
            ),
            borderRadiusValue: 45,
            height: 56,
          ),
        ],
      ),
    );
  }
}

void _showCancelBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const CancellationReasonBottomSheet(),
  );
}
