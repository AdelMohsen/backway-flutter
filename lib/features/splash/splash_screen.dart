import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/cache/cache_methods.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
// استيراد ملف الترجمة

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final isOnBoardingDone = await CacheMethods.getOnBoarding();
    final token = await CacheMethods.getToken();

    if (!isOnBoardingDone) {
      if (mounted) context.goNamed(Routes.ON_BOARDING_SCREEN);
    } else {
      if (token != null && token.isNotEmpty) {
        if (mounted) context.goNamed(Routes.NAV_LAYOUT);
      } else {
        if (mounted) context.goNamed(Routes.CHOICE_ACCOUNT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(4, 131, 114, 1),
                Color.fromRGBO(174, 207, 92, 1),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Lines at the bottom portion of the screen
              Positioned(
                bottom: 20,
                left: -30,
                right: -10,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  "assets/images/line_splash.png",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: -5,
                left: -4,
                right: -40,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset(
                  "assets/images/line_splash.png",
                  fit: BoxFit.fill,
                ),
              ),
              // Logo positioned in upper-center area
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svgs/splash.svg",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
