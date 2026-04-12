import 'package:flutter/material.dart';

import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../text/main_text.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.text,
    this.textColor,
    this.needIcon = true,
    this.maxLines,
    this.fontSize,
  });
  final String? text;
  final Color? textColor;
  final bool needIcon;
  final int? maxLines;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainText(
              text: text ?? AppStrings.noDataFound.tr,
              textAlign: TextAlign.center,
              fontSize: fontSize,
              maxLines: maxLines ?? 2,
              color: textColor ?? Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
