import 'package:flutter/material.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ShipmentDataWidget extends StatelessWidget {
  final String weight;
  final String shipmentType;
  final String receiverPhone;

  const ShipmentDataWidget({
    Key? key,
    required this.weight,
    required this.shipmentType,
    required this.receiverPhone,
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
            AppStrings.shipmentData.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: AppColors.kTitleText,
            ),
          ),
          Divider(color: Color.fromRGBO(247, 247, 247, 1), thickness: 1),
          const SizedBox(height: 16),
          // Weight row
          _buildDataRow(AppStrings.weight.tr, weight),
          const SizedBox(height: 12),
          // Shipment type row
          _buildDataRow(AppStrings.shipmentTypeLabel.tr, shipmentType),
          const SizedBox(height: 12),
          // Receiver phone row
          _buildDataRow(
            mainAppBloc.isArabic
                ? "رقم مستلم الشحنة"
                : "Shipment recipient number",
            receiverPhone,
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
            color: const Color.fromRGBO(160, 160, 167, 1),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
            color: AppColors.kTitleText,
          ),
        ),
      ],
    );
  }
}
