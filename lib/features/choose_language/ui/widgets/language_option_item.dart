import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class LanguageOptionItem<T> extends StatelessWidget {
  final String title;
  final String flagIcon;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const LanguageOptionItem({
    super.key,
    required this.title,
    required this.flagIcon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withOpacity(
                  0.05,
                ), // Matches screenshot dark translucent wrapper
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors
                    .white, // In case flag is transparent, ensure white bg
              ),
              child: ClipOval(
                child: flagIcon.endsWith('.svg')
                    ? SvgPicture.asset(flagIcon, fit: BoxFit.cover)
                    : Image.asset(flagIcon, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            // Language Text
            Expanded(
              child: Text(
                title,
                style: Styles.urbanistSize16w500White.copyWith(
                  color: isSelected
                      ? ColorsApp.kDarkGrey
                      : ColorsApp.kTextGrey2,
                ),
              ),
            ),
            // Custom Radio / Checkmark Icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? null
                    : Border.all(color: Colors.white, width: 1.2),
                color: isSelected
                    ? const Color(0xFFFF7A59) // vibrant orange
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                        weight: 700,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
