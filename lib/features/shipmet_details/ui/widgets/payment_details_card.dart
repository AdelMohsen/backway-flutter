import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class PaymentDetailsCard extends StatelessWidget {
  final String paymentMethod;
  final String shipmentAmount;
  final String taxes;
  final String totalAmount;

  const PaymentDetailsCard({
    super.key,
    required this.paymentMethod,
    required this.shipmentAmount,
    required this.taxes,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(243, 244, 246, 1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.paymentDetails.tr,
                style: Styles.urbanistSize14w600Orange.copyWith(
                  color: const Color.fromRGBO(64, 64, 64, 1),
                ),
              ),
              SvgPicture.asset(SvgImages.arrowDown, width: 24, height: 24),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),
          _buildPaymentRow(SvgImages.pay, AppStrings.paymentMethod.tr, paymentMethod),
          const SizedBox(height: 12),
          _buildPaymentRow(
            SvgImages.truckUnActive,
            AppStrings.shipmentAmount.tr,
            shipmentAmount,
          ),
          const SizedBox(height: 12),
          _buildPaymentRow(SvgImages.docs, AppStrings.taxes.tr, taxes),
          const SizedBox(height: 12),
          _buildPaymentRow(
            SvgImages.total,
            AppStrings.totalAmount.tr,
            totalAmount,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(
    String icon,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 14,
          height: 14,
          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(156, 163, 175, 1),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Styles.urbanistSize12w500Orange.copyWith(
            color: const Color.fromRGBO(107, 114, 128, 1),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Styles.urbanistSize14w600Orange.copyWith(
            fontSize: isTotal ? 16 : 12,
            color: isTotal
                ? const Color.fromRGBO(248, 113, 113, 1)
                : const Color.fromRGBO(55, 65, 81, 1),
          ),
        ),
      ],
    );
  }
}
