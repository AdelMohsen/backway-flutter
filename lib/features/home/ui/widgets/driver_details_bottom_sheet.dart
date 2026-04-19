import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/animations/entrance_animation.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';

class DriverDetailsBottomSheet extends StatelessWidget {
  final String name;
  final double rating;
  final String carType;
  final String distance;
  final int shipments;
  final bool isAvailable;
  final String? profileImageUrl;

  const DriverDetailsBottomSheet({
    super.key,
    required this.name,
    required this.rating,
    required this.carType,
    required this.distance,
    required this.shipments,
    this.isAvailable = true,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 14),

          // Header: Profile, Name, Status, Rating
          EntranceAnimation(
            delay: 0.ms,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image with Verification Badge
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      child: ClipOval(
                        child: Image.asset(
                          ImagesApp.driver1,
                          fit: BoxFit.cover,
                        ),
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

                // Name and Car Type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: Styles.urbanistSize16w600White.copyWith(
                              color: ColorsApp.kPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8ED),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  ImagesApp.star,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: Styles.urbanistSize12w600Orange,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset(
                            SvgImages.car4,
                            width: 20,
                            height: 12,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            carType,
                            style: Styles.urbanistSize12w500Orange.copyWith(
                              color: const Color.fromRGBO(107, 111, 148, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Availability Status
                Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    end: 12,
                    top: 9,
                    bottom: 9,
                  ),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? const Color.fromRGBO(34, 197, 94, 1)
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    isAvailable
                        ? AppStrings.available.tr
                        : AppStrings.notAvailable.tr,
                    style: Styles.urbanistSize12w600Orange.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats Cards: Distance & Shipments
          EntranceAnimation(
            delay: 150.ms,
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: SvgImages.distance,
                    label: AppStrings.distance.tr,
                    value: distance,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    icon: SvgImages.truckUnActive,
                    label: AppStrings.shipmentsCount.tr,
                    value: shipments.toString(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          EntranceAnimation(
            delay: 300.ms,
            child: Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    onPressed: () {
                      CustomNavigator.push(Routes.SHIPMENT_REQUEST);
                    },
                    backgroundColor: ColorsApp.kPrimary,
                    text: AppStrings.shipmentRequest.tr,
                    height: 52,
                    borderRadiusValue: 45,
                    textStyle: Styles.urbanistSize14w700White,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DefaultButton(
                    onPressed: () {
                      CustomNavigator.push(Routes.DRIVER_DETAILS);
                    },
                    backgroundColor: const Color(0xFFF8F9FB),
                    text: AppStrings.viewDetails.tr,
                    height: 52,
                    borderRadiusValue: 45,
                    textStyle: Styles.urbanistSize14w700White.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(107, 114, 128, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF8E92AE),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: Styles.urbanistSize14w500Orange.copyWith(
                  color: Color.fromRGBO(163, 163, 163, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Styles.urbanistSize14w500Orange.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
