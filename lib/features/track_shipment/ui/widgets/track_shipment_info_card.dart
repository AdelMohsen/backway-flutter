import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'trip_progress_timeline.dart';

class TrackShipmentInfoCard extends StatelessWidget {
  final String orderId;
  final String vehicleType;
  final String fromAddress;
  final String toAddress;
  final String status;

  const TrackShipmentInfoCard({
    super.key,
    required this.orderId,
    required this.vehicleType,
    required this.fromAddress,
    required this.toAddress,
    this.status = "Picking Up",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Fixed Top Part (Handle + Header Row + Locations)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(229, 231, 235, 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Header Row
                Row(
                  children: [
                    // Parcel Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color.fromRGBO(244, 244, 244, 1),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/new/de.png',
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // ID & Vehicle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "ID: ",
                                  style: Styles.urbanistSize12w400Orange
                                      .copyWith(
                                        color: const Color.fromRGBO(
                                          130,
                                          134,
                                          171,
                                          1,
                                        ),
                                      ),
                                ),
                                TextSpan(
                                  text: "#$orderId",
                                  style: Styles.urbanistSize16w700Orange
                                      .copyWith(
                                        color: Color.fromRGBO(64, 64, 64, 1),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                SvgImages.car4,
                                width: 22,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                vehicleType,
                                style: Styles.urbanistSize12w500Orange.copyWith(
                                  color: const Color.fromRGBO(107, 114, 128, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 248, 230, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "In Transit",
                            style: Styles.urbanistSize12w600Orange.copyWith(
                              color: const Color.fromRGBO(245, 158, 11, 1),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            SvgImages.truck,
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Color.fromRGBO(251, 191, 36, 1),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Locations
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.from.tr,
                            style: Styles.urbanistSize12w500Orange.copyWith(
                              color: const Color.fromRGBO(156, 163, 175, 1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            fromAddress,
                            style: Styles.urbanistSize12w600Orange.copyWith(
                              color: const Color.fromRGBO(75, 85, 99, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.to.tr,
                            style: Styles.urbanistSize12w500Orange.copyWith(
                              color: const Color.fromRGBO(156, 163, 175, 1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            toAddress,
                            style: Styles.urbanistSize12w600Orange.copyWith(
                              color: const Color.fromRGBO(75, 85, 99, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color.fromRGBO(243, 244, 246, 1)),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Scrollable Trip Progress Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trip Progress",
                    style: Styles.urbanistSize16w600White.copyWith(
                      color: ColorsApp.kPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TripProgressTimeline(
                    steps: [
                      TripStep(
                        label: "Awaiting Payment",
                        isCompleted: true,
                        stepNumber: 1,
                      ),
                      TripStep(
                        label: "Load Accepted",
                        isCompleted: true,
                        stepNumber: 2,
                      ),
                      TripStep(
                        label: "Heading to Pickup",
                        isCompleted: true,
                        stepNumber: 3,
                      ),
                      TripStep(
                        label: "Arrived at Pickup",
                        isCompleted: true,
                        stepNumber: 4,
                      ),
                      TripStep(
                        label: "In Transit to Delivery",
                        isCompleted: true,
                        stepNumber: 5,
                      ),
                      TripStep(
                        label: "Completed",
                        isCompleted: false,
                        stepNumber: 6,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Fixed Bottom Call Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(15, 43, 67, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.phone, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "Call driver",
                      style: Styles.urbanistSize14w700White.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
