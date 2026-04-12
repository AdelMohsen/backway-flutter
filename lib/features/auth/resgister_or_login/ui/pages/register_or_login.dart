import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';

class RegisterOrLogin extends StatelessWidget {
  const RegisterOrLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color.fromRGBO(0, 51, 44, 1),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/login image.png',
                fit: BoxFit.cover,
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(10),
                      Colors.black.withAlpha(10),
                      Colors.black.withAlpha(10),
                      Colors.black.withAlpha(10),
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Main Title - Dual Color
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                    ),
                    child:
                        RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: AppTextStyles.ibmPlexSansSize26w700White
                                    .copyWith(fontSize: 44, height: 1.2),
                                children: [
                                  TextSpan(
                                    text: AppStrings.registerOrLoginBook.tr,
                                  ),
                                  TextSpan(
                                    text: AppStrings
                                        .registerOrLoginYourDelivery
                                        .tr,
                                    style: TextStyle(
                                      color: AppColors.kNeonGreen,
                                    ),
                                  ),
                                  const TextSpan(text: '\n'),
                                  TextSpan(
                                    text: AppStrings
                                        .registerOrLoginAndBrighten
                                        .tr,
                                    style: TextStyle(
                                      color: AppColors.kNeonGreen,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.registerOrLoginYourDay.tr,
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideY(begin: 0.2, end: 0),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  Text(
                        AppStrings.registerOrLoginSubtitle.tr,
                        style: AppTextStyles.ibmPlexSansSize14w400Grey.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 43),
                  // Login Button
                  DefaultButton(
                        text: AppStrings.registerOrLoginLoginButton.tr,
                        onPressed: () {
                          CustomNavigator.push(Routes.LOGIN);
                        },
                        backgroundColor: AppColors.primaryGreenHub,
                        height: 56,
                        borderRadiusValue: 44,
                        textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                            .copyWith(color: Colors.white),
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                      ),
                  const SizedBox(height: 15),
                  // Create Account Text
                  GestureDetector(
                    onTap: () {
                      CustomNavigator.push(Routes.REGISTER);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.ibmPlexSansSize10w500White
                            .copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text:
                                AppStrings.registerOrLoginAlreadyHaveAccount.tr,
                          ),
                          TextSpan(
                            text: AppStrings.registerOrLoginCreateAccount.tr,
                            style: AppTextStyles.ibmPlexSansSize16w600Primary
                                .copyWith(
                                  color: AppColors.kNeonGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                  const SizedBox(height: 40),
                  // Bottom Indicator (Safety margin)
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
