import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class InvoiceDetailRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool showRiyalIcon;
  final bool isHighlighted;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InvoiceDetailRowWidget({
    Key? key,
    required this.label,
    required this.value,
    this.showRiyalIcon = false,
    this.isHighlighted = false,
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          // Label
          Text(
            label,
            style:
                labelStyle ??
                AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                  color: const Color.fromRGBO(107, 114, 128, 1),
                ),
          ),

          // Value + Riyal (عمود واحد)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style:
                    valueStyle ??
                    (isHighlighted
                        ? AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                            color: AppColors.primaryGreenHub,
                          )
                        : AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                            color: AppColors.kTitleText,
                          )),
              ),
              if (showRiyalIcon) ...[
                const SizedBox(width: 4),
                SvgPicture.asset(
                  AppSvg.riyal,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    isHighlighted
                        ? AppColors.primaryGreenHub
                        : Color.fromRGBO(165, 165, 165, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
