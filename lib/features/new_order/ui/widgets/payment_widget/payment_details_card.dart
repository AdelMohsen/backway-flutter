import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'payment_detail_row.dart';

class PaymentDetailsCard extends StatelessWidget {
  final double serviceCost;
  final double vatPercentage;
  final double totalAmount;

  const PaymentDetailsCard({
    Key? key,
    required this.serviceCost,
    required this.vatPercentage,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xfff2f2f2)),
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Top section with padding
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Service cost row
                PaymentDetailRow(
                  label: AppStrings.serviceCost.tr,
                  value: '${serviceCost.toStringAsFixed(0)}-',
                  showRiyal: true,
                ),
                const SizedBox(height: 15),

                // VAT row
                PaymentDetailRow(
                  label: AppStrings.vat.tr,
                  value: '%${vatPercentage.toStringAsFixed(0)}',
                  showRiyal: false,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Total amount section with background - full width
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.totalAmount.tr,
                  style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                    color: Color.fromRGBO(29, 34, 77, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${totalAmount.toStringAsFixed(0)}-',
                      style: AppTextStyles.ibmPlexSansSize18w700Primary
                          .copyWith(
                            color: AppColors.primaryGreenHub,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      AppSvg.riyal,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryGreenHub,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
