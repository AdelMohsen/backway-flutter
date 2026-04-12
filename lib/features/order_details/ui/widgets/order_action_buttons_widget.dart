import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrderActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onTrackOrder;
  final VoidCallback? onCancelOrder;
  final String? orderStatus;

  const OrderActionButtonsWidget({
    Key? key,
    this.onTrackOrder,
    this.onCancelOrder,
    this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (orderStatus != 'pending')
          Expanded(
            child: InkWell(
              onTap: onTrackOrder,
              borderRadius: BorderRadius.circular(45),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenHub,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                  child: Text(
                    AppStrings.trackOrder.tr,
                    style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

        orderStatus == 'pending'
            ? Expanded(
                child: InkWell(
                  onTap: onCancelOrder,
                  borderRadius: BorderRadius.circular(45),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(237, 246, 245, 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.cancelOrder.tr,
                        style: AppTextStyles.ibmPlexSansSize14w700Black
                            .copyWith(color: AppColors.primaryGreenHub),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
