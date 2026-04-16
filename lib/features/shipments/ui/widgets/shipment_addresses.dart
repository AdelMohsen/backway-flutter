import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class ShipmentAddresses extends StatelessWidget {
  final String fromAddress;
  final String toAddress;

  const ShipmentAddresses({
    super.key,
    required this.fromAddress,
    required this.toAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // From
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "From",
                style: Styles.urbanistSize12w500Orange.copyWith(
                  color: const Color.fromRGBO(156, 163, 175, 1),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fromAddress,
                style: Styles.urbanistSize12w600Orange.copyWith(
                  color: const Color.fromRGBO(75, 85, 99, 1),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // To
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "To",
                style: Styles.urbanistSize12w500Orange.copyWith(
                  color: const Color.fromRGBO(156, 163, 175, 1),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                toAddress,
                style: Styles.urbanistSize12w600Orange.copyWith(
                  color: const Color.fromRGBO(75, 85, 99, 1),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
