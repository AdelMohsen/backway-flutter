import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String methodName;
  final String? methodIcon;
  final Color? iconBackgroundColor;

  const PaymentMethodWidget({
    Key? key,
    required this.methodName,
    this.methodIcon,
    this.iconBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.paymentMethod.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Payment method icon
              Container(
                width: 40,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(AppImages.payment, width: 20, height: 20),
              ),
              const SizedBox(width: 12),
              Text(
                methodName,
                style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                  color: const Color.fromRGBO(29, 34, 77, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
