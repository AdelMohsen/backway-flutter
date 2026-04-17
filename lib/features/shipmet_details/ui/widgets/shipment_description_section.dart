import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ShipmentDescriptionSection extends StatelessWidget {
  final String description;

  const ShipmentDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              SvgImages.docs,
              width: 15,
              height: 15,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(156, 163, 175, 1),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.description.tr,
              style: Styles.urbanistSize14w500Orange.copyWith(
                fontSize: 12,
                color: const Color.fromRGBO(156, 163, 175, 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Styles.urbanistSize14w500Orange.copyWith(
            fontSize: 12,
            color: const Color.fromRGBO(82, 82, 82, 1),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
