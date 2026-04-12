import 'package:flutter/material.dart';
import '../theme/colors/styles.dart';
import '../theme/text_styles/text_styles.dart';
import '../translation/all_translation.dart' show allTranslations;
import '../utils/widgets/buttons/default_button.dart';
import '../utils/widgets/text/main_text.dart';

/// Dialog to request notification permission from user
/// Shows before requesting system permission
class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = allTranslations.currentLanguage == 'ar';

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bell Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_active_outlined,
                size: 40,
                color: AppColors.kPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            MainText(
              text: isArabic ? 'تفعيل الإشعارات' : 'Enable Notifications',
              style: AppTextStyles.bodySmMedium.copyWith(
                color: AppColors.kPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            MainText(
              text: isArabic
                  ? 'نحتاج إلى إذنك لإرسال الإشعارات حتى نتمكن من:\n\n• إعلامك بحالة طلباتك\n• إرسال تحديثات مهمة عن الحجوزات\n• تنبيهك بالعروض الخاصة\n• إبقائك على اطلاع بكل جديد'
                  : 'We need your permission to send notifications so we can:\n\n• Notify you about your order status\n• Send important booking updates\n• Alert you about special offers\n• Keep you informed about everything new',
              style: AppTextStyles.bodySmMedium.copyWith(
                color: AppColors.kBlack,
                height: 1.5,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),

            // Allow Button
            DefaultButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User accepted
              },
              text: isArabic ? 'السماح' : 'Allow',
              backgroundColor: AppColors.kPrimary,
            ),
            const SizedBox(height: 12),

            // Don't Allow Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User denied
              },
              child: MainText(
                text: isArabic ? 'لا، شكراً' : 'No, Thanks',
                style: AppTextStyles.bodySmMedium.copyWith(
                  color: AppColors.kBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show the dialog and return user's choice
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // User must choose
      builder: (context) => NotificationPermissionDialog(),
    );
  }
}
