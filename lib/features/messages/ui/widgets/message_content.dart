import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class MessageContent extends StatelessWidget {
  final String name;
  final String message;

  const MessageContent({Key? key, required this.name, required this.message})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          message,
          style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
            color: AppColors.primaryGreenHub, // Teal color for message text
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
