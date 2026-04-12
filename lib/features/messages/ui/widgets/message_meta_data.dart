import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class MessageMetaData extends StatelessWidget {
  final String time;
  final int unreadCount;

  const MessageMetaData({
    Key? key,
    required this.time,
    required this.unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: AppTextStyles.ibmPlexSansSize10w400.copyWith(
            color: AppColors.primaryGreenHub, // Teal color for time
          ),
        ),
        const SizedBox(height: 6),
        if (unreadCount > 0)
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: AppColors.primaryGreenHub,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                unreadCount.toString(),
                style: GoogleFonts.urbanist(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
