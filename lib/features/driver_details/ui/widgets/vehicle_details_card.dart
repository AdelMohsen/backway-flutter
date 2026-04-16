import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class VehicleDetailsCard extends StatelessWidget {
  const VehicleDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(249, 250, 251, 1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vehicle details",
                style: Styles.urbanistSize14w600White.copyWith(
                  color: const Color.fromRGBO(64, 64, 64, 1),
                ),
              ),
              SvgPicture.asset(
                SvgImages.arrowDown,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(130, 134, 171, 1),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),

          // Vehicle Info
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(243, 244, 246, 1),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(SvgImages.car4, width: 28),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cargo Van",
                      style: Styles.urbanistSize16w600White.copyWith(
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgImages.truckUnActive,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Color.fromRGBO(130, 134, 171, 1),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "Load capacity up to 3000 kg",
                            style: Styles.urbanistSize12w500Orange.copyWith(
                              color: const Color.fromRGBO(130, 134, 171, 1),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
