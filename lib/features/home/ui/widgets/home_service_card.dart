import 'package:flutter/material.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import '../../data/models/home_models.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class HomeServiceCard extends StatelessWidget {
  final ServiceModel service;
  final int orderType;

  const HomeServiceCard({
    super.key,
    required this.service,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image - Fixed Height
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 6.5,
              end: 6.5,
              bottom: 10,
              top: 14,
            ),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.nutral60,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: service.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                        bottom: Radius.circular(15),
                      ),
                      child: Image.asset(
                        service.image,
                        fit: BoxFit.cover,
                        height: 105,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.image,
                        size: 40,
                        color: AppColors.kWhite,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),

          // Text Content (Takes available space)
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    service.title,
                    style: AppTextStyles.ibmPlexSansSize12w700Title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service.description,
                    style: AppTextStyles.ibmPlexSansSize8w400Description,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Button Pinned to Bottom
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 8,
              end: 8,
              bottom: 12,
              top: 12,
            ),
            child: DefaultButton(
              width: 160,
              height: 38,
              borderRadiusValue: 28,
              onPressed: () {
                CustomNavigator.push(
                  Routes.CreateNewOrderScreen,
                  extra: orderType,
                );
              },
              backgroundColor: service.buttonColor,
              text: AppStrings.homeCreateOrder.tr,
              textStyle: AppTextStyles.ibmPlexSansSize13w700.copyWith(
                color: service.buttonTextColor,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
