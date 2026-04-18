import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentProgressBar extends StatelessWidget {
  final double? progress;
  final Color statusColor;

  const ShipmentProgressBar({
    super.key,
    this.progress,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final double value = progress ?? 0.75;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progress",
              style: Styles.urbanistSize12w400Orange.copyWith(
                color: const Color.fromRGBO(156, 163, 175, 1),
              ),
            ),
            Text(
              "${(value * 100).toInt()}%",
              style: Styles.urbanistSize12w600Orange.copyWith(
                color: statusColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: const Color.fromRGBO(242, 242, 249, 1),
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ),
      ],
    );
  }
}
