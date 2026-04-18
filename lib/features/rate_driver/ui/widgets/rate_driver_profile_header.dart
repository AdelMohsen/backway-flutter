import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class RateDriverProfileHeader extends StatelessWidget {
  final String name;
  final String vehicleType;
  final String? imageUrl;

  const RateDriverProfileHeader({
    super.key,
    required this.name,
    required this.vehicleType,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(255, 111, 71, 0.1), // Placeholder bg
          ),
          child: Image.asset(ImagesApp.driver1),
        ),
        const SizedBox(height: 16),
        // Driver Name
        Text(
          name,
          style: Styles.urbanistSize16w600White.copyWith(
            color: const Color.fromRGBO(41, 41, 41, 1),
          ),
        ),
        const SizedBox(height: 8),
        // Vehicle Type
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgImages.car4, width: 18, height: 12),
            const SizedBox(width: 6),
            Text(
              vehicleType,
              style: Styles.urbanistSize12w500Orange.copyWith(
                color: const Color.fromRGBO(107, 111, 148, 1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
