import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'shipment_utils.dart';

class ShipmentStatusBadge extends StatelessWidget {
  final String status;
  final bool isCompleted;
  final bool isCancelled;

  const ShipmentStatusBadge({
    super.key,
    required this.status,
    required this.isCompleted,
    required this.isCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: ShipmentUtils.getStatusColor(status).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCompleted
                ? AppStrings.delivered.tr
                : isCancelled
                ? AppStrings.cancelledStatus.tr
                : (status.toLowerCase() == 'in progress' ||
                      status.toLowerCase() == 'picking up')
                ? AppStrings.inTransit.tr
                : status,
            style: Styles.urbanistSize12w600Orange.copyWith(
              color: ShipmentUtils.getStatusColor(status),
            ),
          ),
          const SizedBox(width: 4),
          _buildStatusIcon(),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    final bool isSolid = isCompleted || isCancelled;

    if (isSolid) {
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: ShipmentUtils.getStatusColor(status),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isCancelled
              ? const Icon(Icons.close, color: Colors.white, size: 12)
              : SvgPicture.asset(
                  _getStatusIconPath(),
                  width: 7,
                  height: 7,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      );
    }

    return SvgPicture.asset(
      _getStatusIconPath(),
      width: 14,
      height: 14,
      colorFilter: ColorFilter.mode(
        ShipmentUtils.getStatusColor(status),
        BlendMode.srcIn,
      ),
    );
  }

  String _getStatusIconPath() {
    switch (status.toLowerCase()) {
      case 'new':
        return SvgImages.volt;
      case 'picking up':
      case 'in progress':
        return SvgImages.truck;
      case 'delivered':
      case 'completed':
        return SvgImages.complete;
      case 'canceled':
      case 'cancelled':
        return "";
      default:
        return SvgImages.volt;
    }
  }
}
