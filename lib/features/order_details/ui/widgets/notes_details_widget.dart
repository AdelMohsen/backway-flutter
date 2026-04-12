import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class NotesDetailsWidget extends StatelessWidget {
  final String notes;

  const NotesDetailsWidget({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.additionalNotes.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            notes,
            style: AppTextStyles.ibmPlexSansSize10w500White.copyWith(
              color: const Color.fromRGBO(160, 160, 167, 1),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
