import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';

class CustomSliderThumbShape extends SliderComponentShape {
  final double outerRadius;
  final double innerRadius;

  const CustomSliderThumbShape({this.outerRadius = 12, this.innerRadius = 6});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(outerRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Outer lime green circle
    final outerPaint = Paint()
      ..color = const Color.fromRGBO(186, 220, 88, 1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Inner teal circle
    final innerPaint = Paint()
      ..color = AppColors.primaryGreenHub
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}

/// Custom range slider thumb with lime green outer and teal inner circle
class CustomRangeSliderThumbShape extends RangeSliderThumbShape {
  final double outerRadius;
  final double innerRadius;

  const CustomRangeSliderThumbShape({
    this.outerRadius = 12,
    this.innerRadius = 6,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(outerRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    // Outer lime green circle
    final outerPaint = Paint()
      ..color = const Color.fromRGBO(186, 220, 88, 1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Inner teal circle
    final innerPaint = Paint()
      ..color = AppColors.primaryGreenHub
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}
