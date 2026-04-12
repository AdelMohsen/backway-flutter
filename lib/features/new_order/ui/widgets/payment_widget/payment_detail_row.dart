import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class PaymentDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showRiyal;

  const PaymentDetailRow({
    Key? key,
    required this.label,
    required this.value,
    required this.showRiyal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.ibmPlexSansSize12w400WhiteOpacity.copyWith(
              color: Color.fromRGBO(107, 114, 128, 1),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                color: AppColors.kTitleText,
              ),
            ),
            if (showRiyal) ...[
              const SizedBox(width: 4),
              SvgPicture.asset(
                AppSvg.riyal,
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(152, 152, 152, 1),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
