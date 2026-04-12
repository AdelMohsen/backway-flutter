import 'package:flutter/material.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'change_phone_bottom_sheet.dart';

class ChangePhoneWidget extends StatelessWidget {
  const ChangePhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.wantToChangePhone.tr,
              style: AppTextStyles.ibmPlexSansSize12w400Grey,
            ),
            GestureDetector(
              onTap: () => ChangePhoneBottomSheet.show(context),
              child: Text(
                AppStrings.changePhoneAction.tr,
                style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                  color: AppColors.primaryGreenHub,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
