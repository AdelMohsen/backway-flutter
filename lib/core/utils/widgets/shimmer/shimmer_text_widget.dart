import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTextWidget extends StatelessWidget {
  const ShimmerTextWidget(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.isLoading = false,
    this.maxLines,
  });
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isLoading;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Text(
              text,
              style: style,
              textAlign: textAlign ?? TextAlign.start,
              maxLines: maxLines,
            ),
          )
        : Text(
            text,
            style: style,
            textAlign: textAlign ?? TextAlign.start,
          );
  }
}
