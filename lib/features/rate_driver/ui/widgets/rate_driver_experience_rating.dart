import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/dynamic_rating_bar_widget.dart';

class RateDriverExperienceRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingUpdate;

  const RateDriverExperienceRating({
    super.key,
    required this.rating,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Text(
          AppStrings.rateYourExperience.tr,
          style: Styles.urbanistSize20w500Orange.copyWith(
            color: const Color.fromRGBO(64, 64, 64, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        RatingBar(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemSize: 52,
          ratingWidget: RatingWidget(
            full: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 111, 71, 0.06),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: const Icon(
                  Icons.star_rounded,
                  color: Color.fromRGBO(255, 179, 0, 1),
                  size: 14,
                ),
              ),
            ),
            half: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 243, 239, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: const Icon(
                  Icons.star_half_rounded,
                  color: Color.fromRGBO(255, 179, 0, 1),
                  size: 14,
                ),
              ),
            ),
            empty: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 243, 239, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: const Icon(
                  Icons.star_rounded,
                  color: Color.fromRGBO(255, 210, 198, 1),
                  size: 14,
                ),
              ),
            ),
          ),
          onRatingUpdate: onRatingUpdate,
        ),
      ],
    );
  }
}
