import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrderActionButtons extends StatelessWidget {
  final int tabIndex;
  final VoidCallback? onCancelOrder;
  final VoidCallback? onShipmentDetails;
  final VoidCallback? onTrackOrder;
  final VoidCallback? onOrderDetails;

  const OrderActionButtons({
    super.key,
    required this.tabIndex,
    this.onCancelOrder,
    this.onShipmentDetails,
    this.onTrackOrder,
    this.onOrderDetails,
  });

  @override
  Widget build(BuildContext context) {
    switch (tabIndex) {
      case 0: // Scheduled - 2 buttons: Details (green) + Cancel (red outline)
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onShipmentDetails,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenHub,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.shipmentDetailsTitle.tr,
                      style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Cancel Order Button (red)
            const SizedBox(width: 10),
            // Shipment Details Button (green)
            Expanded(
              child: GestureDetector(
                onTap: onCancelOrder,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 246, 246, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.cancelOrder.tr,
                      style: AppTextStyles.ibmPlexSansSize10w700.copyWith(
                        color: const Color.fromRGBO(216, 41, 41, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

      case 1: // In Transit - 2 buttons: Details (dark green) + Track (light green)
        return Row(
          children: [
            // Track Order Button (light green)
            Expanded(
              child: GestureDetector(
                onTap: onOrderDetails,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenHub,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.orderDetails.tr,
                      style: AppTextStyles.ibmPlexSansSize10w700.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: onTrackOrder,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8D959),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.trackOrder.tr,
                      style: AppTextStyles.ibmPlexSansSize10w700.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Order Details Button (dark green)
          ],
        );

      case 2: // Previous - 1 full-width button: Order Details
      default:
        return GestureDetector(
          onTap: onOrderDetails,
          child: Container(
            width: double.infinity,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryGreenHub,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                AppStrings.orderDetails.tr,
                style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
    }
  }
}
