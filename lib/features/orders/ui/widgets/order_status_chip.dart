import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../../data/models/orders_model.dart';

class OrderStatusChip extends StatelessWidget {
  final OrderModel order;
  final int tabIndex;

  const OrderStatusChip({super.key, required this.order, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color bgColor;
    Color textColor;
    Color iconColor;
    IconData iconData = Icons.check_circle;

    if (order.status?.key == 'cancelled') {
        statusText = AppStrings.cancelled.tr;
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFEF4444);
        iconColor = const Color(0xFFEF4444);
        iconData = Icons.cancel;
    } else {
        switch (tabIndex) {
          case 1: // Scheduled - Under Process (orange)
            statusText = AppStrings.inDelivery.tr;
            bgColor = Colors.blue.shade50;
            textColor = Colors.blue;
            iconColor = Colors.blue;
            break;
          case 0: // In Transit - In Delivery (green)
            statusText = AppStrings.underProcess.tr;
            bgColor = const Color(0xFFFFF8E6);
            textColor = const Color(0xFFF59E0B);
            iconColor = const Color(0xFFF59E0B);
            break;
          case 2: // Previous - Delivered (red)
          default:
            statusText = AppStrings.delivered.tr;
            bgColor = const Color(0xFFEDF6F5);
            textColor = AppColors.primaryGreenHub;
            iconColor = AppColors.primaryGreenHub;
            break;
        }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 9),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, size: 14, color: iconColor),
            const SizedBox(width: 4),

            Text(
              statusText,
              style: AppTextStyles.ibmPlexSansSize10w700Success.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
