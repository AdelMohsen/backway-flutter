import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OfferCarrierDetails extends StatelessWidget {
  final String name;
  final String orderNumber;
  final String price;

  const OfferCarrierDetails({
    super.key,
    required this.name,
    required this.orderNumber,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(29, 34, 77, 1),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              AppStrings.orderNumberLabel.tr,
              style: AppTextStyles.ibmPlexSansSize10w400.copyWith(
                color: const Color.fromRGBO(138, 138, 138, 1),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                orderNumber,
                style: AppTextStyles.ibmPlexSansSize14w700Primary.copyWith(
                  color: AppColors.primaryGreenHub,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.priceLabel.tr,
              style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                color: const Color.fromRGBO(138, 138, 138, 1),
              ),
            ),
            const SizedBox(width: 3),
            Flexible(
              child: Text(
                price,
                style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                  color: AppColors.primaryGreenHub,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              AppSvg.riyal,
              width: 12,
              height: 12,
              colorFilter: const ColorFilter.mode(
                AppColors.kNeonGreen,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ],
    );
  }
}
