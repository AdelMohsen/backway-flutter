import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../widgets/shipment_request_stepper.dart';
import 'step_one_details.dart';
import 'step_two_details.dart';
import 'step_three_details.dart';

class ShipmentRequestScreen extends StatefulWidget {
  const ShipmentRequestScreen({super.key});

  @override
  State<ShipmentRequestScreen> createState() => _ShipmentRequestScreenState();
}

class _ShipmentRequestScreenState extends State<ShipmentRequestScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      bottomNavigationBar: _buildActionButtons(),
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
                      child: Transform.flip(
                        flipX: mainAppBloc.isArabic ? true : false,
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
                      AppStrings.shipmentRequest.tr,
                      textAlign: TextAlign.center,
                      style: Styles.urbanistSize20w600Orange.copyWith(
                        color: const Color.fromRGBO(38, 38, 38, 1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44), // To balanced the row visually
                ],
              ),
            ),
            const SizedBox(height: 32),
            ShipmentRequestStepper(currentStep: currentStep),
            const SizedBox(height: 10),
            _buildCurrentStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return const StepOneDetails();
      case 1:
        return const StepTwoDetails();
      case 2:
        return const StepThreeDetails();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentStep == 0) ...[
            _buildSecondaryButton(
              text: AppStrings.copyShipment.tr,
              icon: SvgImages.docs,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            _buildSecondaryButton(
              text: AppStrings.newShipment.tr,
              icon: SvgImages.docs,
              isNew: true,
              onPressed: () {},
            ),
            const SizedBox(height: 24),
          ],
          _buildPrimaryButton(
            text: currentStep == 2
                ? AppStrings.payment.tr
                : currentStep == 1
                ? AppStrings
                      .confirm
                      .tr // Or confirmDetails if added
                : AppStrings.confirmPackage.tr,
            onPressed: () {
              if (currentStep < 2) {
                setState(() {
                  currentStep++;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String text,
    required String icon,
    bool isNew = false,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(243, 244, 255, 1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Styles.urbanistSize20w600Orange.copyWith(
                fontSize: 18,
                color: ColorsApp.kPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    ColorsApp.kPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                if (isNew)
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(243, 244, 255, 1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(1),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 10,
                      color: ColorsApp.kPrimary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: ColorsApp.kPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const SizedBox(width: 44),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Styles.urbanistSize16w600White.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
