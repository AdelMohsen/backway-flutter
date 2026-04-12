import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart' show AppColors;
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class OrderTypeCard extends StatelessWidget {
  final bool isSelected;
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const OrderTypeCard({
    required this.isSelected,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreenHub
                : const Color.fromRGBO(224, 224, 224, 1),
            width: isSelected ? 1 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            /// Image with Radio Button
            Stack(
              children: [
                Container(
                  height: 92,
                  width: 152,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// Radio Button Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.directional(
                        end: 8,
                        start: 8,
                        top: 8,
                      ),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryGreenHub
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryGreenHub,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Title and Subtitle in Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.ibmPlexSansSize12w700Black
                            .copyWith(
                              color: isSelected
                                  ? AppColors.kBlack
                                  : Color.fromRGBO(165, 165, 165, 1),
                            ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.ibmPlexSansSize8w400Description
                            .copyWith(
                              fontSize: 9,
                              color: isSelected
                                  ? const Color.fromRGBO(136, 136, 136, 1)
                                  : const Color.fromRGBO(170, 170, 170, 1),
                            ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
