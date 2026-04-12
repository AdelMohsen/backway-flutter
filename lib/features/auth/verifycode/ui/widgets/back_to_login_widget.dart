import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class BackToLoginWidget extends StatelessWidget {
  const BackToLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(Routes.REGISTER_OR_LOGIN, extra: false),
      child: Center(
        child: Text(
          AppStrings.backToLogin.tr,
          style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
            color: const Color.fromRGBO(69, 69, 74, 1),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
