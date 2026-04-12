import 'package:responsive_builder/responsive_builder.dart';

class AppConstant {
  static const ScreenBreakpoints breakpoints = ScreenBreakpoints(
    desktop: 1024, // Desktop starts at 1024px
    tablet: 768, // Tablet starts at 768px
    watch: 320, // Watches are 320px or less
  );

  static const double appbarheight = 70.0;
  //NULL FROM BACKEND
  static const nullFromBack = 'N-F-B';
  static String? deviceToken;
  static bool hasNotificationPermission = false;
  static String countryCode = '966';
}
