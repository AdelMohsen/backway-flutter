import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/avalable_vechile/ui/widgets/vehicle_card.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class AvailableVehicleScreen extends StatelessWidget {
  const AvailableVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        backgroundColor: AppColors.kWhite,
        child: Column(
          children: [
            /// 🔹 Gradient Header + User Info
            GradientHeaderLayout(
              showAction:
                  true, // Hiding default back button if needed, or set true if back is needed
              title: AppStrings.availableVehicles.tr,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // User Profile Card (Simulated based on design image)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [],
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // RTL Alignment
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.kWhite,
                                radius: 25,
                                backgroundImage: AssetImage(
                                  AppImages.imageCarriers,
                                ), // Placeholder or use existing user image
                                // In real app, might use network image from UserCubit
                              ),
                              SizedBox(width: 12),
                              Text(
                                "معاذ خالد الحيطانى",
                                style: AppTextStyles.ibmPlexSansSize14w500Grey
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFFF4E5,
                                  ), // Light orange
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "4.5",
                                      style: AppTextStyles
                                          .ibmPlexSansSize10w500White
                                          .copyWith(
                                            color: Color.fromRGBO(
                                              255,
                                              186,
                                              8,
                                              1,
                                            ),
                                          ),
                                    ),
                                    const SizedBox(width: 4),
                                    SvgPicture.asset(AppSvg.starCarriers),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Truck Card
                      VehicleCard(
                        colorCard: Color.fromRGBO(244, 254, 238, 1),
                        title: AppStrings.truck.tr,
                        sizeText: AppStrings.heavySize.tr,
                        imagePath: SvgPicture.asset(
                          AppSvg.delveryTruck,
                        ), // Placeholder
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      // Car Card
                      VehicleCard(
                        colorCard: Color.fromRGBO(4, 131, 114, 0.07),

                        title: AppStrings.car.tr,
                        sizeText: AppStrings.mediumSize.tr,
                        imagePath: SvgPicture.asset(AppSvg.car), // Placeholder
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      // Car Card
                      VehicleCard(
                        colorCard: Color.fromRGBO(255, 241, 244, 1),

                        title: AppStrings.car.tr,
                        sizeText: AppStrings.mediumSize.tr,
                        imagePath: SvgPicture.asset(AppSvg.car), // Placeholder
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
