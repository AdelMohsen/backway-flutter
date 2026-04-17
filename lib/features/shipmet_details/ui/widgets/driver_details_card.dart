import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class DriverDetailsCard extends StatelessWidget {
  final String name;
  final String vehicleType;
  final double rating;

  const DriverDetailsCard({
    super.key,
    required this.name,
    required this.vehicleType,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(243, 244, 246, 1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.driverDetails.tr,
            style: Styles.urbanistSize14w600Orange.copyWith(
              color: const Color.fromRGBO(64, 64, 64, 1),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              // Profile Image with Verification Badge
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: ClipOval(
                      child: Image.asset(ImagesApp.driver1, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: -9,
                    child: SvgPicture.asset(
                      SvgImages.verify,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and Vehicle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Styles.urbanistSize14w600White.copyWith(
                        fontSize: 16,
                        color: const Color.fromRGBO(38, 38, 38, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(SvgImages.car4, width: 20, height: 12),
                        const SizedBox(width: 8),
                        Text(
                          vehicleType,
                          style: Styles.urbanistSize12w500Orange.copyWith(
                            color: const Color.fromRGBO(107, 111, 148, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Rating Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImagesApp.star, width: 14, height: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: Styles.urbanistSize12w600Orange.copyWith(
                        color: const Color.fromRGBO(249, 115, 22, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
