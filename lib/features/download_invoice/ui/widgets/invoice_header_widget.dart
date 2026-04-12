import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class InvoiceHeaderWidget extends StatelessWidget {
  final String? title;
  final String? companyName;
  final String? address;

  const InvoiceHeaderWidget({
    Key? key,
    this.title,
    this.companyName,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // Invoice Title (e.g., Simplified Tax Invoice)
            if (title != null)
              Text(
                title!,
                style: AppTextStyles.ibmPlexSansSize14w600Black.copyWith(
                  color: AppColors.primaryGreenHub,
                ),
                textAlign: TextAlign.center,
              ),
            if (title != null) const SizedBox(height: 12),
            
            // Company Name
            if (companyName != null)
              Text(
                companyName!,
                style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                  color: AppColors.kTitleText,
                ),
                textAlign: TextAlign.center,
              ),
            if (companyName != null) const SizedBox(height: 6),
            
            // Address
            if (address != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  address!,
                  style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                    color: const Color.fromRGBO(107, 114, 128, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
