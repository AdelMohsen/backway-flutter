import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentRequestLabel extends StatelessWidget {
  final String text;
  final bool isRequired;
  final double? fontSize;

  const ShipmentRequestLabel({
    super.key,
    required this.text,
    this.isRequired = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: RichText(
        text: TextSpan(
          text: text,
          style: Styles.urbanistSize14w500Orange.copyWith(
            fontSize: fontSize ?? 14,
            fontWeight: fontSize != null ? FontWeight.w600 : FontWeight.w500,
            color: const Color.fromRGBO(38, 38, 38, 1),
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: "*",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
