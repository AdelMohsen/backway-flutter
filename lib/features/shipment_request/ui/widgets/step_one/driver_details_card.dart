import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class DriverDetailsCard extends StatelessWidget {
  const DriverDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.driverDetails.tr,
            style: Styles.urbanistSize14w600Orange.copyWith(
              color: const Color.fromRGBO(41, 41, 41, 1),
            ),
          ),
          const SizedBox(height: 16),
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
                    width: 60,
                    height: 60,
                    child: ClipOval(
                      child: Image.asset(ImagesApp.driver1, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: -4,
                    child: SvgPicture.asset(
                      SvgImages.verify,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and Car Type
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.dummyDriverName.tr,
                      style: Styles.urbanistSize16w600White.copyWith(
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(SvgImages.car4),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.cargoVan.tr,
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
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8ED),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImagesApp.star, width: 16, height: 16),
                    const SizedBox(width: 6),
                    Text("4.5", style: Styles.urbanistSize14w600Orange),
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
