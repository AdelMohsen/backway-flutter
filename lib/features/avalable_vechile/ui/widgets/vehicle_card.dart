import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class VehicleCard extends StatelessWidget {
  final Widget imagePath;
  final String title;
  final Color colorCard;
  final String sizeText;
  final Color? backgroundColor;

  const VehicleCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.colorCard,
    required this.sizeText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 198, // Approximate height from design
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white ?? Colors.white, // Very light green default
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: colorCard,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 303,
            height: 120,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: imagePath,
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.ibmPlexSansSize18w700Primary),

                // Size Tag (Bottom Left for RTL)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(174, 207, 92, 0.2),
                      width: 1,
                    ),
                    color: Color.fromRGBO(244, 254, 238, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    sizeText,
                    style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
                      color: Color.fromRGBO(
                        174,
                        207,
                        92,
                        1,
                      ), // Assuming dark green text for readability
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Title (Bottom Right for RTL, but we use alignment)
        ],
      ),
    );
  }
}
