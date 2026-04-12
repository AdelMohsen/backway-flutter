import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

class FormfiledsRechargeWidget extends StatefulWidget {
  final TextEditingController amountController;
  final ValueChanged<String?>? onPaymentMethodChanged;
  final String? selectedPaymentMethod;

  const FormfiledsRechargeWidget({
    Key? key,
    required this.amountController,
    this.onPaymentMethodChanged,
    this.selectedPaymentMethod,
  }) : super(key: key);

  @override
  State<FormfiledsRechargeWidget> createState() =>
      _FormfiledsRechargeWidgetState();
}

class _FormfiledsRechargeWidgetState extends State<FormfiledsRechargeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultFormField(
          hintText: AppStrings.enterAmount.tr,
          borderColor: const Color.fromRGBO(247, 247, 247, 1),
          controller: widget.amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.start,
          style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(),
          fillColor: const Color.fromRGBO(247, 247, 247, 1),
          borderRadious: 45,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            TextInputFormatter.withFunction((oldValue, newValue) {
              if (newValue.text.isEmpty) return newValue;
              final regex = RegExp(r'^\d*\.?\d{0,4}$');
              return regex.hasMatch(newValue.text) ? newValue : oldValue;
            }),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.pleaseEnterAmount.tr;
            }

            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return AppStrings.pleaseEnterAmount.tr;
            }

            if (amount > 100000) {
              return mainAppBloc.isArabic
                  ? 'المبلغ لا يمكن أن يتجاوز 100,000 ريال'
                  : 'Amount cannot exceed 100,000 SAR';
            }
            return null;
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [50, 100, 200, 300].map((amount) {
            final isSelected =
                widget.amountController.text == amount.toString();
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.amountController.text = amount.toString();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xfff0f7f6) : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected
                          ? const Color.fromRGBO(4, 131, 114, 0.1)
                          : const Color(0xFFF7F7F7),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        amount.toString(),
                        style: AppTextStyles.ibmPlexSansSize10w400Grey.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.primaryGreenHub
                              : const Color(0xFF9E9E9E),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppSvg.riyal,
                        width: 12,
                        height: 12,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? AppColors.kBlack
                              : Color.fromRGBO(191, 191, 191, 1),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.paymentMethod.tr,
              style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                fontSize: 14,
                color: AppColors.kTitleText,
              ),
            ),

            // Text(
            //   AppStrings.change.tr,
            //   style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
            //     color: AppColors.primaryGreenHub,
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 10),
        DefaultDropdownFormField(
          prefixIcon: Image.asset(AppImages.payment, width: 20, height: 20),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          value: widget.selectedPaymentMethod,
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
          onChanged: widget.onPaymentMethodChanged,
        ),
      ],
    );
  }
}
