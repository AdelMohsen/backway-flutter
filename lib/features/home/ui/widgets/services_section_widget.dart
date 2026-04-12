import 'package:flutter/material.dart';
import 'package:greenhub/core/assets/app_images.dart';
import '../../data/models/home_models.dart';
import 'home_service_card.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ServicesSectionWidget extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesSectionWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppStrings.homeServicesTitle.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black,
              ),
              Image.asset(AppImages.offer, width: 17, height: 28),

              // Gold/Amber Gift Icon
            ],
          ),
        ),
        const SizedBox(height: 4),

        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Wrap(
            spacing: 6, // Horizontal spacing
            runSpacing: 12, // Vertical spacing
            children: services.asMap().entries.map((entry) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 40 - 6) / 2,
                height: 265, // Fixed height for uniform cards
                child: HomeServiceCard(
                  service: entry.value,
                  orderType: entry.key,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
