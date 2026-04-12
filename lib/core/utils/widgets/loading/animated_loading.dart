import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/utils/extensions/media_query_helper.dart';

/// Enum for different loading animation styles
enum LoadingStyle {
  /// Spinning circle animation
  spinningCircle,

  /// Pulsing dots animation
  pulsingDots,

  /// Bouncing ball animation
  bouncingBall,

  /// Fading circle animation
  fadingCircle,

  /// Wave animation
  wave,

  /// Four rotating dots
  fourRotatingDots,
}

/// Animated loading widget with multiple styles and overlay option
class AnimatedLoading extends StatelessWidget {
  final LoadingStyle style;
  final Color? color;
  final double size;

  const AnimatedLoading({
    Key? key,
    this.style = LoadingStyle.fadingCircle,
    this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? AppColors.primaryGreenHub;

    switch (style) {
      case LoadingStyle.spinningCircle:
        return SpinKitCircle(color: loadingColor, size: size);

      case LoadingStyle.pulsingDots:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: loadingColor,
          size: size,
        );

      case LoadingStyle.bouncingBall:
        return LoadingAnimationWidget.bouncingBall(
          color: loadingColor,
          size: size,
        );

      case LoadingStyle.fadingCircle:
        return SpinKitFadingCircle(color: loadingColor, size: size);

      case LoadingStyle.wave:
        return LoadingAnimationWidget.waveDots(color: loadingColor, size: size);

      case LoadingStyle.fourRotatingDots:
        return LoadingAnimationWidget.fourRotatingDots(
          color: loadingColor,
          size: size,
        );
    }
  }

  /// Shows an animated loading overlay dialog
  static void showAnimatedLoading({
    LoadingStyle style = LoadingStyle.fourRotatingDots,
    Color? color,
    double size = 60.0,
    bool barrierDismissible = false,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: CustomNavigator.context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
          body: SizedBox(
            height: MediaQueryHelper.appMediaQuerySize.height,
            width: MediaQueryHelper.appMediaQuerySize.width,
            child: Center(
              child: AnimatedLoading(
                style: style,
                color: color ?? AppColors.primaryGreenHub,
                size: size,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Hides the loading overlay
  static void hideAnimatedLoading() {
    CustomNavigator.pop();
  }

  /// Shows a full screen loading overlay without dialog box
  static void showFullScreenLoading({
    LoadingStyle style = LoadingStyle.fadingCircle,
    Color? color,
    double size = 60.0,
    bool barrierDismissible = false,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: CustomNavigator.context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.2),
          body: SizedBox(
            height: MediaQueryHelper.appMediaQuerySize.height,
            width: MediaQueryHelper.appMediaQuerySize.width,
            child: Center(
              child: AnimatedLoading(
                style: style,
                color: color ?? Colors.white,
                size: size,
              ),
            ),
          ),
        );
      },
    );
  }
}
