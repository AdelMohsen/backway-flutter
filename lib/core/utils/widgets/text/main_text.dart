import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? textHeight;
  final Color? color;
  // final String? fontFamily;
  final TextDirection? textDirection;
  final double? horPadding;
  final double? verPadding;
  final TextDecoration? decoration;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Function()? onTap;
  final TextStyle? style;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final Color? decorationColor;
  final double? decorationThickness;

  // Gradient properties
  final bool useGradient;
  final List<Color>? gradientColors;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;

  const MainText({
    super.key,
    this.text,
    this.textAlign,
    this.fontSize,
    this.color,
    // this.fontFamily,
    this.textDirection,
    this.textHeight,
    this.horPadding,
    this.verPadding,
    this.decoration,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
    this.onTap,
    this.style,
    this.overflow,
    this.padding,
    this.decorationColor,
    this.decorationThickness,
    this.useGradient = false,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = style ??
        TextStyle(
          // height: textHeight ?? 1.5,
          fontSize: fontSize,
          overflow: TextOverflow.ellipsis,
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          decoration: decoration,
          decorationColor: decorationColor,

          decorationThickness: decorationThickness,
        );

    final textWidget = Text(
      text ?? '',
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      style: useGradient
          ? textStyle.copyWith(
              color: Colors.white) // White to show gradient clearly
          : textStyle,
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: horPadding ?? 0, vertical: verPadding ?? 0),
        child:
            useGradient && gradientColors != null && gradientColors!.length >= 2
                ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                      colors: gradientColors!,
                      begin: gradientBegin ?? Alignment.topCenter,
                      end: gradientEnd ?? Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: textWidget,
                  )
                : textWidget,
      ),
    );
  }
}
