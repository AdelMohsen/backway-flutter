import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ContactOptionsWidget extends StatelessWidget {
  const ContactOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.doYouHave.tr,
                  style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(),
                ),
                TextSpan(
                  text: AppStrings.complaint.tr,
                  style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                    color: AppColors.primaryGreenHub,
                  ),
                ),
                TextSpan(
                  text: AppStrings.teamReady.tr,
                  style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(),
                ),
                TextSpan(
                  text: AppStrings.toHelpYou.tr,
                  style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                    color: AppColors.primaryGreenHub,
                  ),
                ),
                const TextSpan(text: ' 📞🤝', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            CustomNavigator.push(Routes.FILE_COMPLAINT);
          },
          child: Container(
            width: 335,
            height: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(243, 243, 243, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 60,
              width: 311,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: const Color(0xFFF5F5F5), width: 1),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenHub,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 7),
                    SvgPicture.asset(
                      AppSvg.sms,
                      colorFilter: ColorFilter.mode(
                        AppColors.kWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      AppStrings.sendComplaintOrInquiry.tr,
                      style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(174, 207, 92, 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kWhite,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
