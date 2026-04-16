import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(249, 250, 251, 1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Reviews",
            style: Styles.urbanistSize14w600White.copyWith(
              color: const Color.fromRGBO(64, 64, 64, 1),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),

          // Reviews List
          _buildReviewItem(),
          const SizedBox(height: 12),
          _buildReviewItem(),
          const SizedBox(height: 12),
          _buildReviewItem(),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(243, 244, 246, 1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.person,
              color: Color.fromRGBO(156, 163, 175, 1),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Alex M.",
                      style: Styles.urbanistSize14w600White.copyWith(
                        color: ColorsApp.kPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 248, 235, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            SvgImages.star,
                            width: 12,
                            height: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "4.5",
                            style: Styles.urbanistSize12w600Orange.copyWith(
                              color: ColorsApp.KorangePrimary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "A respectful driver who is punctual;\nexcellent service.",
                  style: Styles.urbanistSize12w400Orange.copyWith(
                    color: const Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
