import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class TransportTypeWidget extends StatelessWidget {
  final String transportType;
  final String transportSubType;

  const TransportTypeWidget({
    Key? key,
    required this.transportType,
    required this.transportSubType,
  }) : super(key: key);

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
          Text(
            AppStrings.transportType.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: AppColors.kTitleText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            transportType,
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: const Color.fromRGBO(160, 160, 167, 1),
            ),
          ),
          if (transportSubType.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              transportSubType,
              style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                color: const Color.fromRGBO(150, 150, 150, 1),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
