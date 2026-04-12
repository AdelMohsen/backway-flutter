import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/auth/login/ui/widgets/main_container_and_filed.dart';
import 'package:greenhub/features/auth/login/ui/widgets/title_description_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: CustomScaffoldWidget(
        resizeToAvoidBottomInset: true,
        needAppbar: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            /// Background Image
            Positioned.fill(
              child:
                  Image.asset(
                        AppImages.loginLogo3,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                      )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(1.0, 1.0),
                        duration: 1200.ms,
                        curve: Curves.easeOut,
                      ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.center,
                    colors: [
                      AppColors.kNeonGreen.withAlpha(45),
                      AppColors.primaryGreenHub.withAlpha(50),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms),
            ),

            /// Main Content
            Positioned.fill(
              child: Column(
                children: const [
                  /// Top Section (Logo + Title)
                  Expanded(child: TitleDescriptionLogin()),

                  /// Bottom Section (Login Card) - uses intrinsic height
                  _LoginBottomSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBottomSection extends StatelessWidget {
  const _LoginBottomSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        /// Decorative background - extends above main card
        Positioned(
          left: -4,
          right: -4,
          bottom: -0,
          top: -15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
        ),

        /// Main Card
        const MainContainerAndFiled(),
      ],
    );
  }
}
