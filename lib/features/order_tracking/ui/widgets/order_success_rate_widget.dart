import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';

class OrderSuccessRateWidget extends StatelessWidget {
  final VoidCallback onRatePressed;

  const OrderSuccessRateWidget({Key? key, required this.onRatePressed})
    : super(key: key);

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

          // Success Icon
          Image.asset(
            AppImages.success,
            height: 120, // Adjust height as needed based on asset
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 24),

          // Title with emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: MainText(
                  text: 'تم التسليم بنجاح!',
                  style: AppTextStyles.ibmPlexSansSize24w700White.copyWith(
                    color: const Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              const Text('🎉', style: TextStyle(fontSize: 24)),
            ],
          ),

          const SizedBox(height: 12),

          // Subtitle
          MainText(
            text:
                'شحنتك وصلت بسلام! شكرًا لثقتك في SHIPHUB.\nساعدنا لنقدم خدمة أفضل — قيّم تجربتك مع السائق في دقيقة.',
            style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
              color: const Color.fromRGBO(146, 146, 146, 1),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Rate Button
          DefaultButton(
            borderRadius: BorderRadius.circular(45),
            height: 60,
            text: 'تقييم الناقل',
            onPressed: onRatePressed,
            backgroundColor: AppColors.primaryGreenHub,
            textColor: Colors.white,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required VoidCallback onRatePressed,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          OrderSuccessRateWidget(onRatePressed: onRatePressed),
    );
  }
}
