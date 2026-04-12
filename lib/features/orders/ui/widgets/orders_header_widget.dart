import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrdersHeaderWidget extends StatelessWidget {
  const OrdersHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25), // Adjusted padding
      decoration: const BoxDecoration(
        color: AppColors.primaryGreenHub,
        gradient: LinearGradient(
          colors: [AppColors.kLightGreen, AppColors.primaryGreenHub],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back/Action Icon (using a similar style to design: rounded opaque bg)
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.kWhite,
                        size: 20,
                      ),
                    ),
                  ),

                  // Title
                  Text(
                    AppStrings.myOrders.tr,
                    style: AppTextStyles.ibmPlexSansSize24w700White,
                  ),

                  // Empty SizedBox to balance the row (or another icon if needed)
                  const SizedBox(width: 44),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
