import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentRating extends StatelessWidget {
  const ShipmentRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Rate this delivery",
          style: Styles.urbanistSize14w500Orange.copyWith(
            color: const Color.fromRGBO(156, 163, 175, 1),
          ),
        ),
        Row(
          children: List.generate(
            5,
            (index) => const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.star,
                color: Color.fromRGBO(209, 213, 219, 1),
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
