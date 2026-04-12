import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';

class RatingSuccessBottomSheet extends StatelessWidget {
  final VoidCallback onOrderDetails;
  final VoidCallback onShipmentHistory;

  const RatingSuccessBottomSheet({
    Key? key,
    required this.onOrderDetails,
    required this.onShipmentHistory,
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

          const SizedBox(height: 30),

          // Title with emoji
          MainText(
            text: mainAppBloc.isArabic
                ? "شكراً لتقييمك! 🙏"
                : "Thank you for your rating! 🙏",
            style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
              color: const Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainText(
              text: mainAppBloc.isArabic
                  ? "نُقدر رأيك، لأنه يساعدنا في تقديم خدمة أفضل.\nيمكنك الآن مراجعة تفاصيل الطلب أو إرسال شحنة جديدة."
                  : "We appreciate your opinion, as it helps us provide better service.\nYou can now review order details or send a new shipment.",
              style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
                color: const Color.fromRGBO(146, 146, 146, 1),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),

          // Buttons Row
          Row(
            children: [
              // Shipment History Button (Light Green)
              Expanded(
                child: GestureDetector(
                  onTap: onOrderDetails,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenHub,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.orderDetails.tr,
                          style: AppTextStyles.ibmPlexSansSize10w700.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: onShipmentHistory,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8D959),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          mainAppBloc.isArabic
                              ? "سجل الشحنة"
                              : "Shipment History",
                          style: AppTextStyles.ibmPlexSansSize10w700.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required VoidCallback onOrderDetails,
    required VoidCallback onShipmentHistory,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => RatingSuccessBottomSheet(
        onOrderDetails: onOrderDetails,
        onShipmentHistory: onShipmentHistory,
      ),
    );
  }
}
