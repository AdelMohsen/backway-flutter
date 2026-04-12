import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrderSuccessBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? orderId;
  final VoidCallback? onDismiss;

  const OrderSuccessBottomSheet({
    Key? key,
    required this.title,
    this.subtitle,
    this.orderId,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 60,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Success Icon with decorative elements
          Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Image.asset(AppImages.success),
            ],
          ),

          const SizedBox(height: 24),

          // Title with emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: MainText(
                  text: title,
                  style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
                    color: const Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 12),
            MainText(
              text: subtitle!,
              style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
                color: const Color.fromRGBO(146, 146, 146, 1),
              ),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 32),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Track order button (green)
                // Order details button (teal)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      if (orderId != null) {
                        CustomNavigator.push(Routes.ORDER_DETAILS, extra: orderId);
                      } else {
                        CustomNavigator.push(Routes.ORDER_DETAILS);
                      }
                    },
                    child: Container(
                      height: 50,

                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenHub,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.orderDetails.tr,
                          style: AppTextStyles.ibmPlexSansSize14w600White,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      CustomNavigator.push(
                        Routes.ORDER_TRACKING,
                        pathParameters: {'orderId': orderId?.toString() ?? '0'},
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(174, 207, 92, 1),
                        borderRadius: BorderRadius.circular(85),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.trackOrder.tr,
                          style: AppTextStyles.ibmPlexSansSize14w600White
                              .copyWith(color: AppColors.kTitleText),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    int? orderId,
    VoidCallback? onDismiss,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => OrderSuccessBottomSheet(
        title: title,
        subtitle: subtitle,
        orderId: orderId,
        onDismiss: onDismiss,
      ),
    ).then((_) {
      if (onDismiss != null) onDismiss();
    });
  }
}
