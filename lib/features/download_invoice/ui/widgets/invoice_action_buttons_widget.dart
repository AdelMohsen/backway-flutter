import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class InvoiceActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onDownload;
  final VoidCallback? onBackToHome;

  const InvoiceActionButtonsWidget({
    Key? key,
    this.onDownload,
    this.onBackToHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Download Invoice Button
          InkWell(
            onTap: onDownload,
            borderRadius: BorderRadius.circular(45),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryGreenHub,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.downloadInvoice.tr,
                    style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    AppSvg.import,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Back to Home Button
          InkWell(
            onTap: onBackToHome,
            borderRadius: BorderRadius.circular(45),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color.fromRGBO(237, 246, 245, 1),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Center(
                child: Text(
                  mainAppBloc.isArabic ? "عودة للرئيسية" : "Back to Home",
                  style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                    color: AppColors.primaryGreenHub,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
