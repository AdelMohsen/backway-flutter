import 'package:flutter/material.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';

class MoreMenuItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final Widget? trailing;

  const MoreMenuItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 20,
          top: 18,
          bottom: 16,
        ),
        child: Row(
          children: [
            // Icon on the right
            // Text in the middle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.ibmPlexSansSize13w600Primary.copyWith(
                      color: isDestructive
                          ? const Color(0xFFD92D20)
                          : AppColors.kBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
                      color: AppColors.kGreyDescriptionText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 13),

            // Trailing widget (Arrow or Custom)
            trailing ??
                Container(
                  width: 27,
                  height: 27,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Color(0xFF8A8A8A),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
