import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';

class CustomeExpandableText extends StatelessWidget {
  const CustomeExpandableText(
    this.longText, {
    super.key,
    this.color,
    this.decoration,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.maxFont,
    this.maxLines,
    this.minFont,
    this.overflow,
    this.style,
    this.textAlign,
    this.wordSpacing,
    this.seeMoreColor,
    this.textHeight,
  });
  final String longText;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final double? minFont;
  final double? maxFont;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? fontSize;
  final TextStyle? style;
  final double? letterSpacing;
  final double? wordSpacing;
  final Color? seeMoreColor;
  final double? textHeight;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      longText,
      expandText: 'AppStrings.readMore.tr()',
      collapseText: 'AppStrings.showLess.tr()',
      expandOnTextTap: true,
      collapseOnTextTap: true,
      maxLines: maxLines ?? 4,
      linkColor: seeMoreColor ?? AppColors.kPrimary,
      style:
          style ??
          TextStyle(
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.w400,
            decoration: decoration,
            fontSize: fontSize,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
            height: textHeight,
          ),
      animation: true,
      animationCurve: Curves.ease,
      animationDuration: const Duration(milliseconds: 750),
      textAlign: textAlign,
    );
  }
}
