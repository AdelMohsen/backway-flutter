import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/download_invoice/data/models/invoice_model.dart';
import 'package:greenhub/features/download_invoice/ui/widgets/invoice_detail_row_widget.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class InvoiceDetailsSectionWidget extends StatelessWidget {
  final InvoiceData data;

  const InvoiceDetailsSectionWidget({Key? key, required this.data})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = data.labels;
    final amounts = data.amounts;
    final company = data.company;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          // Invoice Number
          if (data.invoiceNumber != null)
            InvoiceDetailRowWidget(
              label: labels?.invoiceNumber ?? AppStrings.invoiceNumberLabel.tr,
              value: data.invoiceNumber.toString(),
            ),

          // Order Number
          if (data.orderNumber != null)
            InvoiceDetailRowWidget(
              label: labels?.orderNumber ?? AppStrings.orderNumberLabel.tr,
              value: data.orderNumber!,
            ),

          // VAT Number
          if (company?.taxNumber != null)
            InvoiceDetailRowWidget(
              label: AppStrings.vatNumberLabel.tr,
              value: company!.taxNumber!,
            ),

          // Invoice Date
          if (data.invoiceDate != null)
            InvoiceDetailRowWidget(
              label: labels?.invoiceDate ?? AppStrings.invoiceDateLabel.tr,
              value: data.invoiceDate!,
            ),

          // Divider
          if (data.invoiceDate != null || company?.taxNumber != null)
            Container(
              width: double.infinity,
              height: 1,
              color: const Color.fromRGBO(247, 247, 247, 1),
            ),

          // Delivery Fees (Subtotal)
          if (amounts?.subtotal != null)
            InvoiceDetailRowWidget(
              label: labels?.deliveryFee ?? AppStrings.deliveryFeesLabel.tr,
              value: amounts!.subtotal.toString(),
              showRiyalIcon: true,
            ),

          if (amounts?.subtotal != null)
            Container(
              width: double.infinity,
              height: 1,
              color: const Color.fromRGBO(247, 247, 247, 1),
            ),

          // VAT Percentage
          if (amounts?.vatRate != null)
            InvoiceDetailRowWidget(
              label: labels?.vatRate ?? AppStrings.vatPercentageLabel.tr,
              value: '${((double.tryParse(amounts!.vatRate.toString()) ?? 0) * 100).toInt()}%',
            ),

          // VAT Amount
          if (amounts?.vatAmount != null)
            InvoiceDetailRowWidget(
              label: labels?.vatAmount ?? AppStrings.vatAmountLabel.tr,
              value: amounts!.vatAmount.toString(),
              showRiyalIcon: true,
            ),

          // Total Amount with VAT (highlighted)
          if (amounts?.totalIncludingVat != null)
            InvoiceDetailRowWidget(
              valueStyle: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: AppColors.primaryGreenHub,
              ),
              labelStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                color: Colors.black,
              ),
              label:
                  labels?.totalIncludingVat ??
                  AppStrings.totalAmountWithVatLabel.tr,
              value: amounts!.totalIncludingVat.toString(),
              showRiyalIcon: true,
              isHighlighted: true,
            ),
        ],
      ),
    );
  }
}
