import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class CarrierNameAndPrice extends StatelessWidget {
  final String name;
  final String price;

  const CarrierNameAndPrice({Key? key, required this.name, required this.price})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
            color: Color.fromRGBO(29, 34, 77, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              AppStrings.priceLabel.tr,
              style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                color: const Color.fromRGBO(152, 152, 152, 1),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$price',
              style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                color: AppColors.primaryGreenHub,
              ),
            ),
            const SizedBox(width: 2),
            SvgPicture.asset(
              AppSvg.riyal,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(174, 207, 92, 1),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
