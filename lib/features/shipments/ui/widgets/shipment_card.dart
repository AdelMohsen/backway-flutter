import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'shipment_addresses.dart';
import 'shipment_card_actions.dart';
import 'shipment_progress_bar.dart';
import 'shipment_rating.dart';
import 'shipment_status_badge.dart';
import 'shipment_utils.dart';

class ShipmentCard extends StatelessWidget {
  final String orderId;
  final String vehicleType;
  final String fromAddress;
  final String toAddress;
  final String status;
  final double? progress;
  final VoidCallback? onDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onTracking;

  const ShipmentCard({
    super.key,
    required this.orderId,
    required this.vehicleType,
    required this.fromAddress,
    required this.toAddress,
    this.status = "New",
    this.progress,
    this.onDetails,
    this.onCancel,
    this.onTracking,
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
      margin: const EdgeInsets.only(bottom: 16),
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
          // Order ID + Status
          Row(
            children: [
              // Package icon
              _buildPackageIcon(),
              const SizedBox(width: 16),
              // Order ID + Car Type
              Expanded(
                child: _buildHeaderInfo(),
              ),
              // Status badge
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
            ShipmentAddresses(
              fromAddress: fromAddress,
              toAddress: toAddress,
            ),
          ],

          // Progress Section
          if (progress != null ||
              (status.toLowerCase() == 'in progress' ||
                  status.toLowerCase() == 'picking up')) ...[
            const SizedBox(height: 14),
            ShipmentProgressBar(
              progress: progress,
              statusColor: ShipmentUtils.getStatusColor(status),
            ),
          ],

          if (!isCancelled) ...[
            const SizedBox(height: 8),
            const Divider(
              color: Color.fromRGBO(243, 244, 246, 1),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            if (isCompleted)
              const ShipmentRating()
            else
              ShipmentCardActions(
                status: status,
                onDetails: onDetails,
                onCancel: onCancel,
                onTracking: onTracking,
              ),
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
        child: Image.asset(
          'assets/images/new/de.png',
          width: 28,
          height: 28,
        ),
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
              "ID: ",
              style: Styles.urbanistSize12w400Orange.copyWith(
                color: const Color.fromRGBO(130, 134, 171, 1),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "#$orderId",
              style: Styles.urbanistSize16w700Orange.copyWith(
                color: ColorsApp.kPrimary,
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
                color: const Color.fromRGBO(130, 134, 171, 1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
