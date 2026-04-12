import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class AddressDetailsWidget extends StatelessWidget {
  final String pickupPoint;
  final String pickupCity;
  final String destination;
  final String destinationCity;

  const AddressDetailsWidget({
    Key? key,
    required this.pickupPoint,
    required this.pickupCity,
    required this.destination,
    required this.destinationCity,
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
          Row(
            children: [
              Text(
                AppStrings.address.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black,
              ),
              Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(245, 245, 245, 1),
                ),
                child: Center(
                  child: SvgPicture.asset(AppSvg.edit3, width: 18, height: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Pickup Point
          _buildAddressRow(
            AppStrings.pickupPointLabel.tr,
            pickupPoint,
            pickupCity,
          ),
          const SizedBox(height: 16),
          // Destination
          _buildAddressRow(
            AppStrings.destinationLabel.tr,
            destination,
            destinationCity,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow(String label, String address, String city) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
            color: const Color.fromRGBO(160, 160, 167, 1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                address,
                textAlign: TextAlign.start,
                style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                  color: AppColors.kTitleText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
