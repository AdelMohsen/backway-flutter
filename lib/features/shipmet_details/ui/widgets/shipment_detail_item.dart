import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentDetailItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const ShipmentDetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 15, height: 15),
          const SizedBox(width: 8),
          Text(
            label,
            style: Styles.urbanistSize12w500Orange.copyWith(
              color: const Color.fromRGBO(156, 163, 175, 1),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: Styles.urbanistSize12w500Orange.copyWith(
              color: const Color.fromRGBO(64, 64, 64, 1),
            ),
          ),
        ],
      ),
    );
  }
}
