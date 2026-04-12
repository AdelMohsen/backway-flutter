import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrderNumberWidget extends StatelessWidget {
  final String orderNumber;

  const OrderNumberWidget({Key? key, required this.orderNumber})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.orderNumber.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: AppColors.kTitleText,
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: orderNumber));
              CustomToast.showSuccess(
                context,
                message: AppStrings.orderNumberCopied.tr,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  orderNumber,
                  textDirection: TextDirection.ltr,
                  style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                    color: AppColors.primaryGreenHub,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: AppColors.primaryGreenHub,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
