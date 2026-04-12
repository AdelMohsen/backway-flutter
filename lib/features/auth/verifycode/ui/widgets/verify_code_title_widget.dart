import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class VerifyCodeTitleWidget extends StatelessWidget {
  const VerifyCodeTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.twoFactorAuthTitle.tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.ibmPlexSansSize26w700White.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.verifyMobileDesc.tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
            color: const Color(0xFF919191),
          ),
        ),
      ],
    );
  }
}
