import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String locationName;
  const HomeHeaderWidget({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 16, bottom: 14),
        decoration: const BoxDecoration(color: ColorsApp.KorangePrimary),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Location Pill
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 140.0),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                0.5,
                              ), // Good balanced border
                              width: 1.2,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(
                                  0.3,
                                ), // Bright top-left edge
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // SHRINK TO FIT
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(SvgImages.locations),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  "Banff National Park , Canda",
                                  style: Styles.urbanistSize14w700White
                                      .copyWith(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bell Notification
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.6),
                                width: 1.2,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(
                                    0.4,
                                  ), // Bright top-left edge
                                  Colors.white.withOpacity(0.05),
                                ],
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                SvgImages.bell,

                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 20,
                        child: Container(
                          width: 6.5,
                          height: 6.5,
                          decoration: const BoxDecoration(
                            color: Color(
                              0xFFD12A2A,
                            ), // Soft dark red for the dot
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Title with box image
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.homeBannerTitle.tr,
                    style: Styles.urbanistSize16w600White.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    'assets/images/box.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
