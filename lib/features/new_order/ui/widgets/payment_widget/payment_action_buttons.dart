import 'package:flutter/material.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/new_order/ui/widgets/order_diolog_sucess.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class PaymentActionButtons extends StatelessWidget {
  const PaymentActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Complete payment button
        InkWell(
          onTap: () {
            OrderSuccessBottomSheet.show(
              context,
              title: AppStrings.paymentSuccessTitle.tr,
              subtitle: AppStrings.paymentSuccessSubtitle.tr,
            );
          },
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primaryGreenHub,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Center(
              child: Text(
                AppStrings.completePayment.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Cancel order button
        InkWell(
          onTap: () {
            CustomNavigator.push(Routes.NAV_LAYOUT, clean: true);
          },
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 240, 240, 1),
              borderRadius: BorderRadius.circular(45),
              border: Border.all(
                color: Color.fromRGBO(244, 67, 54, 1),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                AppStrings.cancelOrder.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                  color: Color.fromRGBO(255, 0, 0, 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
