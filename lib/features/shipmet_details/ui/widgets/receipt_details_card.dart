import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ReceiptDetailsCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;

  const ReceiptDetailsCard({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
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
                AppStrings.receiptDetails.tr,
                style: Styles.urbanistSize14w600Orange.copyWith(
                  color: const Color.fromRGBO(64, 64, 64, 1),
                ),
              ),
              SvgPicture.asset(SvgImages.arrowDown, width: 24, height: 24),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 8),
          Text(
            name,
            style: Styles.urbanistSize14w600White.copyWith(
              fontSize: 16,
              color: const Color.fromRGBO(38, 38, 38, 1),
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(SvgImages.locs1, address),
          const SizedBox(height: 12),
          _buildInfoRow(SvgImages.phone1, phone),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 14, height: 14),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Styles.urbanistSize12w500Orange.copyWith(
              color: const Color.fromRGBO(130, 134, 171, 1),
            ),
          ),
        ),
      ],
    );
  }
}
