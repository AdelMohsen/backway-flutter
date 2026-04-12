import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'payment_widget/payment_details_card.dart';
import 'payment_widget/payment_method_section.dart';
import 'payment_widget/coupon_field.dart';
import 'payment_widget/terms_checkbox.dart';
import 'payment_widget/payment_action_buttons.dart';

class PaymentWidget extends StatefulWidget {
  final double serviceCost;
  final double vatPercentage;
  final double totalAmount;

  const PaymentWidget({
    Key? key,
    this.serviceCost = 55,
    this.vatPercentage = 15,
    this.totalAmount = 55,
  }) : super(key: key);

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String? _selectedPaymentMethod = 'madaCard';
  bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            // Payment details card container
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(2, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Text(
                      AppStrings.paymentDetails.tr,
                      style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                        color: AppColors.kTitleText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Payment details card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PaymentDetailsCard(
                      serviceCost: widget.serviceCost,
                      vatPercentage: widget.vatPercentage,
                      totalAmount: widget.totalAmount,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Payment method and actions container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    offset: Offset(2, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Payment method section
                  PaymentMethodSection(
                    selectedPaymentMethod: _selectedPaymentMethod,
                    onChanged: (val) {
                      setState(() {
                        _selectedPaymentMethod = val;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // Coupon field
                ],
              ),
            ),
            const SizedBox(height: 20),

            const CouponField(),

            const SizedBox(height: 20),

            // Terms checkbox
            TermsCheckbox(
              value: _isTermsAccepted,
              onChanged: (val) {
                setState(() {
                  _isTermsAccepted = val ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            // Action buttons
            const PaymentActionButtons(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
