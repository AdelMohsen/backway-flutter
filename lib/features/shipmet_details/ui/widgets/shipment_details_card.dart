import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'shipment_addresses.dart';
import 'shipment_status_badge.dart';
import 'shipment_description_section.dart';
import 'shipment_detail_item.dart';

class ShipmentDetailsCard extends StatelessWidget {
  final String orderId;
  final String vehicleType;
  final String fromAddress;
  final String toAddress;
  final String status;
  final String loadingCapacity;
  final String type;
  final String size;
  final String description;

  const ShipmentDetailsCard({
    super.key,
    required this.orderId,
    required this.vehicleType,
    required this.fromAddress,
    required this.toAddress,
    required this.status,
    required this.loadingCapacity,
    required this.type,
    required this.size,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        status.toLowerCase() == 'delivered' ||
        status.toLowerCase() == 'completed';
    final bool isCancelled =
        status.toLowerCase() == 'canceled' ||
        status.toLowerCase() == 'cancelled';

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
          // Header: ID, Vehicle, Status
          Row(
            children: [
              _buildPackageIcon(),
              const SizedBox(width: 16),
              Expanded(child: _buildHeaderInfo()),
              ShipmentStatusBadge(
                status: status,
                isCompleted: isCompleted,
                isCancelled: isCancelled,
              ),
            ],
          ),

          if (!isCancelled) ...[
            const SizedBox(height: 14),
            // Addresses
            ShipmentAddresses(fromAddress: fromAddress, toAddress: toAddress),
            const SizedBox(height: 12),
            Divider(
              color: const Color.fromRGBO(243, 244, 246, 1),
              thickness: 1,
            ),
            const SizedBox(height: 12),
            // Metrics
            ShipmentDetailItem(
              icon: SvgImages.capacity,
              label: AppStrings.loadingCapacity.tr,
              value: loadingCapacity,
            ),
            ShipmentDetailItem(
              icon: SvgImages.truckUnActive,
              label: AppStrings.type.tr,
              value: type,
            ),
            ShipmentDetailItem(
              icon: SvgImages.size,
              label: AppStrings.size.tr,
              value: size,
            ),

            const SizedBox(height: 4),
            // Description
            ShipmentDescriptionSection(description: description),
          ],
        ],
      ),
    );
  }

  Widget _buildPackageIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: const Color.fromRGBO(244, 244, 244, 1),
        ),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset('assets/images/new/de.png', width: 28, height: 28),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.orderIdLabel.tr,
              style: Styles.urbanistSize12w400Orange.copyWith(
                color: const Color.fromRGBO(130, 134, 171, 1),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "#$orderId",
              style: Styles.urbanistSize16w700Orange.copyWith(
                color: Color.fromRGBO(64, 64, 64, 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SvgPicture.asset(SvgImages.car4, width: 14, height: 10),
            const SizedBox(width: 4),
            Text(
              vehicleType,
              style: Styles.urbanistSize12w400Orange.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(130, 134, 171, 1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
