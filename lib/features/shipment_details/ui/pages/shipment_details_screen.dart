import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/shipment_details/ui/widgets/driver_details_card.dart';
import 'package:greenhub/features/shipment_details/ui/widgets/vehicle_details_card.dart';
import 'package:greenhub/features/shipment_details/ui/widgets/reviews_card.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
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
                            child: SvgPicture.asset(
                              SvgImages.kBackIcon,
                              colorFilter: const ColorFilter.mode(
                                Color.fromRGBO(36, 35, 39, 1),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Driver details",
                            textAlign: TextAlign.center,
                            style: Styles.urbanistSize20w600Orange.copyWith(
                              color: Color.fromRGBO(38, 38, 38, 1),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 44,
                        ), // To balanced the row visually
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DriverDetailsCard(),
                  const VehicleDetailsCard(),
                  const ReviewsCard(),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 24,
                top: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: DefaultButton(
                  text: "Shipment request",
                  height: 52,
                  borderRadiusValue: 100,
                  textStyle: Styles.urbanistSize16w600White,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
