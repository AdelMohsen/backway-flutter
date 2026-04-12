import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/colors/styles.dart';

class VerifyCodeIconWidget extends StatelessWidget {
  const VerifyCodeIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 113,
          height: 113,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(4, 131, 114, 0.08),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 69,
          height: 69,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(4, 131, 114, 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppSvg.otp,
              width: 35,
              height: 35,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGreenHub,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
