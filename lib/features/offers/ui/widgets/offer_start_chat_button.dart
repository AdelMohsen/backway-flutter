import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OfferStartChatButton extends StatelessWidget {
  final VoidCallback onTap;

  const OfferStartChatButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(249, 249, 249, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color.fromRGBO(242, 242, 242, 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Text(
                AppStrings.startChatWithCarrier.tr,
                style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                  color: const Color.fromRGBO(73, 73, 73, 1),
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                AppSvg.massageIcon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(138, 138, 138, 1),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
