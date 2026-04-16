import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AnimationDirection { vertical, horizontal }

class EntranceAnimation extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;
  final AnimationDirection direction;

  const EntranceAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 30.0,
    this.direction = AnimationDirection.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOut)
        .slide(
          begin: direction == AnimationDirection.vertical
              ? Offset(0, offset / 100) // Normalized offset
              : Offset(offset / 100, 0),
          end: Offset.zero,
          duration: duration,
          curve: Curves.easeOutQuad,
        );
  }
}
