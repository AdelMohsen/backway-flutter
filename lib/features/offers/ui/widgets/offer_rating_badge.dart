import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class OfferRatingBadge extends StatelessWidget {
  final double rating;

  const OfferRatingBadge({super.key, required this.rating});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              '$rating',
              style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
                color: const Color.fromRGBO(255, 186, 8, 1),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 2),
          SvgPicture.asset(AppSvg.starCarriers),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
