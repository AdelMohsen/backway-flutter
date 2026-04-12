import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';

class ChangeMobileWidget extends StatelessWidget {
  const ChangeMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 30, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                AppStrings.editMobileNumber.tr,
                style: AppTextStyles.ibmPlexSansSize26w700White.copyWith(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          DefaultPhoneFormField(
            controller: TextEditingController(),
            hintText: AppStrings.phoneHint.tr,
            fillColor: const Color(0xffF7F7F7),
            borderRadious: 44,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          ),
          const SizedBox(height: 55),
          DefaultButton(
            text: AppStrings.yes.tr,
            onPressed: () {
              SuccessBottomSheet.show(
                context,
                title: AppStrings.accountCreatedSuccessMessage.tr,
                subtitle: AppStrings.accountCreationFailedMessage.tr,
              );
            },
            backgroundColor: AppColors.primaryGreenHub,
            height: 62,
            borderRadiusValue: 44,
            textStyle: AppTextStyles.ibmPlexSansSize18w700Primary.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => CustomNavigator.pop(),
            child: Text(
              AppStrings.back.tr,
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff666666),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
