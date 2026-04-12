import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.dashWidth = 5,
    this.color = AppColors.kPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          30,
          (_) => Container(width: dashWidth, height: height, color: color),
        ),
      ),
    );
  }
}
