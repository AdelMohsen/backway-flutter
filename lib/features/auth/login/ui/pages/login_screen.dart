import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/auth/login/ui/widgets/main_container_and_filed.dart';

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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorsApp.KorangePrimary, ColorsApp.KorangeSecondary],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                /// Top Section
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 17,
                    end: 16,
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            SvgImages.logo,
                            width: 50,
                            height: 38,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.push(Routes.LANGUAGE);
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(SvgImages.lang),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.welcomeBack.tr,
                        style: Styles.urbanistSize28w700Orange.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.signInSubtitle.tr,
                        style: Styles.urbanistSize14w400White.copyWith(
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const Expanded(child: _LoginBottomSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginBottomSection extends StatelessWidget {
  const _LoginBottomSection();

  @override
  Widget build(BuildContext context) {
    return const MainContainerAndFiled();
  }
}
