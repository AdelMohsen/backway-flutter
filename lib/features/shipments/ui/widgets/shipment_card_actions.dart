import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentCardActions extends StatelessWidget {
  final String status;
  final VoidCallback? onDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onTracking;

  const ShipmentCardActions({
    super.key,
    required this.status,
    this.onDetails,
    this.onCancel,
    this.onTracking,
  });

  @override
  Widget build(BuildContext context) {
    final String statusLower = status.toLowerCase();
    final bool isInProgress =
        statusLower == 'in progress' || statusLower == 'picking up';
    final bool isNew = statusLower == 'new';

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onDetails,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: ColorsApp.kPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgImages.boxx,
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Shipment details",
                    style: Styles.urbanistSize14w600White.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Visibility(
            visible: isNew || isInProgress,
            child: GestureDetector(
              onTap: isInProgress ? onTracking : onCancel,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isInProgress
                      ? const Color.fromRGBO(243, 245, 250, 1)
                      : const Color.fromRGBO(254, 242, 242, 1),
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Text(
                  isInProgress ? "Tracking" : "Cancel shipment",
                  style: Styles.urbanistSize14w700White.copyWith(
                    color: isInProgress
                        ? ColorsApp.kPrimary
                        : const Color.fromRGBO(185, 28, 28, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
