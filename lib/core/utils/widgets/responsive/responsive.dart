import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const Responsive({
    super.key,
    this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  });

  @override
  Widget build(BuildContext context) {
    //Returns the widget which is more appropriate for the screen size
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return largeScreen!;
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        //if medium screen not available, then return large screen
        return mediumScreen ?? largeScreen!;
      } else {
        //if small screen implementation not available, then return large screen
        return smallScreen ?? largeScreen!;
      }
    });
  }

  //Making these methods static, so that they can be used as accessed from other widgets

  //Small screen is any screen whose width is less than 800 pixels
  static bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  //Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  static bool isMedium(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;
  }

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900 &&
        MediaQuery.of(context).size.width < 1200;
  }

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isXLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200 &&
        MediaQuery.of(context).size.width < 1400;
  }

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isXXLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1400;
  }

  static dynamic returnValueAdjustResponsive(BuildContext context, dynamic xxlarge,
      dynamic xLarge, dynamic large, dynamic mediam, dynamic small) {
    if (Responsive.isXXLarge(context)) {
      return xxlarge;
    } else if (Responsive.isXLarge(context)) {
      return xLarge;
    } else if (Responsive.isLarge(context)) {
      return large;
    } else if (Responsive.isMedium(context)) {
      return mediam;
    } else {
      return small;
    }
  }
}
