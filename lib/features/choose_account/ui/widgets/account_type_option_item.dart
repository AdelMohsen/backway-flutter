import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class AccountTypeOptionItem<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const AccountTypeOptionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Card
          Container(
            margin: const EdgeInsets.only(top: 24), // Space for image overflow
            padding: const EdgeInsets.only(
              left: 94, // Space for the person image
              right: 14,
              top: 27,
              bottom: 27,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Styles.urbanistSize16w600White.copyWith(
                          color: isSelected ? ColorsApp.kPrimary : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Styles.urbanistSize12w400White.copyWith(
                          color: isSelected
                              ? ColorsApp.subColor
                              : ColorsApp.subColorUnSelcted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Indicator Icon
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.white, width: 1.2),
                    color: isSelected
                        ? ColorsApp.KorangePrimary
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
              ],
            ),
          ),

          // Person Image Overflowing
          Positioned(
            left: 10,
            bottom: 0,
            child: Image.asset(
              imagePath,
              // Adjust size to overflow properly without stretching
              height: 110,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
