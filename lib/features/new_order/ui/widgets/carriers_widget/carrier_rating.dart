import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class CarrierRatingBadge extends StatelessWidget {
  final double rating;

  const CarrierRatingBadge({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsetsDirectional.only(start: 8, end: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 246, 234, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$rating',
            style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
              color: const Color.fromRGBO(255, 186, 8, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 2),
          SvgPicture.asset(AppSvg.starCarriers),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
