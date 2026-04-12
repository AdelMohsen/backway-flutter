import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';

class PaymentMethodSection extends StatelessWidget {
  final String? selectedPaymentMethod;
  final ValueChanged<String?> onChanged;

  const PaymentMethodSection({
    Key? key,
    required this.selectedPaymentMethod,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.paymentMethod.tr,
          style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
            fontSize: 14,
            color: AppColors.kTitleText,
          ),
        ),
        const SizedBox(height: 16),

        DefaultDropdownFormField(
          prefixIcon: Image.asset(AppImages.payment, width: 20, height: 20),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              AppStrings.change.tr,
              style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryGreenHub,
                color: AppColors.primaryGreenHub,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          value: selectedPaymentMethod,
          items: [
            DropdownMenuItem(
              value: 'madaCard',
              child: Text(AppStrings.madaCard.tr),
            ),
            DropdownMenuItem(
              value: 'visaMastercard',
              child: Text(AppStrings.visaMastercard.tr),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
