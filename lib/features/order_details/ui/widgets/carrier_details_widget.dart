import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class CarrierDetailsWidget extends StatelessWidget {
  final String carrierName;
  final String? carrierImage;
  final double rating;
  final String reviewsCount;
  final VoidCallback? onTalkWithDriver;
  final bool isChatLoading;

  const CarrierDetailsWidget({
    Key? key,
    required this.carrierName,
    this.carrierImage,
    required this.rating,
    required this.reviewsCount,
    this.onTalkWithDriver,
    this.isChatLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.carrierDetailsTitle.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Carrier Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  image: carrierImage != null
                      ? DecorationImage(
                          image: NetworkImage(carrierImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: carrierImage == null
                    ? Center(child: Icon(Icons.person_2_outlined))
                    : null,
              ),
              const SizedBox(width: 12),
              // Carrier Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carrierName,
                      style: AppTextStyles.ibmPlexSansSize14w600White.copyWith(
                        color: const Color.fromRGBO(29, 34, 77, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 246, 234, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              AppSvg.starCarriers,
                              width: 10,
                              height: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$rating',
                          style: AppTextStyles.ibmPlexSansSize12w500Title
                              .copyWith(color: Color.fromRGBO(255, 186, 8, 1)),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($reviewsCount ${AppStrings.reviews.tr})',
                          style: AppTextStyles.ibmPlexSansSize12w400Grey
                              .copyWith(
                                color: const Color.fromRGBO(130, 134, 171, 1),
                              ),
                        ),
                      ],
                    ),
                    if (onTalkWithDriver != null) ...[
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: isChatLoading ? null : onTalkWithDriver,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(232, 240, 254, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isChatLoading
                                  ? const SizedBox(
                                      height: 14,
                                      width: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.chat_bubble_outline,
                                      size: 16,
                                      color: Color(0xFF2196F3),
                                    ),
                              const SizedBox(width: 8),
                              Text(
                                AppStrings.talkWithDriver.tr,
                                style: AppTextStyles.ibmPlexSansSize12w500Title
                                    .copyWith(
                                  color: const Color(0xFF2196F3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
