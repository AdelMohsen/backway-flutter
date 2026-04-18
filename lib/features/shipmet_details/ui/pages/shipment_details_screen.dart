import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';

import '../../../../core/assets/app_svg.dart';
import '../widgets/cancel_shipment_bottom_sheet.dart';
import '../widgets/driver_details_card.dart';
import '../widgets/payment_details_card.dart';
import '../widgets/receipt_details_card.dart';
import '../widgets/shipment_details_card.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  final String status;
  final double? progress;

  const ShipmentDetailsScreen({super.key, this.status = "New", this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      bottomNavigationBar: _buildBottomAction(context),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Dedicated ShipmentDetailsCard
                  ShipmentDetailsCard(
                    orderId: "28765543",
                    vehicleType: "Cargo Van",
                    fromAddress: "Toronto, ON · M5V 2H1",
                    toAddress: "Vancouver, BC · V6B 3K9",
                    status: status,
                    progress: progress,
                    loadingCapacity: "10000 dl",
                    type: "Heavy Duty",
                    size: "Large",
                    description:
                        "A medium-sized box containing clothes and personal items. The package is securely sealed and not fragile. No liquids or sharp objects inside.",
                  ),
                  const SizedBox(height: 16),
                  // ReceiptDetailsCard
                  const ReceiptDetailsCard(
                    name: "Adam Ismail",
                    address: "123 Maple Street, Toronto, ON, M5H 2N2",
                    phone: "123456789999",
                  ),
                  const SizedBox(height: 16),
                  // DriverDetailsCard
                  const DriverDetailsCard(
                    name: "Jaskson Oliver",
                    vehicleType: "Cargo Van",
                    rating: 4.5,
                  ),
                  const SizedBox(height: 16),
                  // PaymentDetailsCard
                  const PaymentDetailsCard(
                    paymentMethod: "Electronic wallet",
                    shipmentAmount: "500\$",
                    taxes: "150\$",
                    totalAmount: "3400\$",
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => CustomNavigator.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(175, 175, 175, 0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: mainAppBloc.isArabic ? math.pi : 0,
                child: SvgPicture.asset(
                  SvgImages.kBackIcon,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(36, 35, 39, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              AppStrings.shipmentDetailsTitle.tr,
              textAlign: TextAlign.center,
              style: Styles.urbanistSize20w600Orange.copyWith(
                color: const Color.fromRGBO(38, 38, 38, 1),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    final bool isCompleted =
        status.toLowerCase() == 'delivered' ||
        status.toLowerCase() == 'completed';
    final bool isInProgress =
        status.toLowerCase() == 'in progress' ||
        status.toLowerCase() == 'picking up' ||
        status.toLowerCase() == 'in transit';

    String buttonText = AppStrings.cancelShipment.tr;
    Color backgroundColor = const Color.fromRGBO(254, 242, 242, 1);
    Color textColor = const Color.fromRGBO(220, 38, 38, 1);
    VoidCallback? onPressed = () => _showCancelBottomSheet(context);

    if (isCompleted) {
      buttonText = AppStrings.rateDelivery.tr;
      backgroundColor = const Color.fromRGBO(240, 244, 253, 1);
      textColor = const Color.fromRGBO(0, 45, 133, 1);
      onPressed = () {
        CustomNavigator.push(Routes.RATE_DRIVER);
      };
    } else if (isInProgress) {
      buttonText = AppStrings.liveTracking.tr;
      backgroundColor = const Color.fromRGBO(240, 244, 253, 1);
      textColor = const Color.fromRGBO(0, 45, 133, 1);
      onPressed = () {
        CustomNavigator.push(Routes.TRACK_SHIPMENT);
      };
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: DefaultButton(
          onPressed: onPressed,
          text: buttonText,
          backgroundColor: backgroundColor,
          textStyle: Styles.urbanistSize14w700White.copyWith(color: textColor),
          borderRadiusValue: 45,
          height: 52,
        ),
      ),
    );
  }

  void _showCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const CancelShipmentBottomSheet(),
    );
  }
}
