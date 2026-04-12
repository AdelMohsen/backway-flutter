import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class TitleDescriptionLogin extends StatelessWidget {
  const TitleDescriptionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Logo
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SvgPicture.asset(AppSvg.iconApp, width: 45, height: 50)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideY(begin: -0.2, end: 0, curve: Curves.easeOutQuad),
                ),

                const SizedBox(height: 30),

                /// Main Title
                const SizedBox(height: 14),

                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 50, end: 50),
                  child:
                      Column(
                            children: [
                              RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: AppTextStyles
                                          .ibmPlexSansSize30w700White,
                                      children: [
                                        TextSpan(
                                          text: AppStrings.loginTitleMain.tr,
                                        ),
                                        TextSpan(
                                          text:
                                              AppStrings.loginTitleDelivery.tr,
                                          style: AppTextStyles
                                              .ibmPlexSansSize30w700White
                                              .copyWith(
                                                color: AppColors.kNeonGreen,
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 400.ms)
                                  .slideY(
                                    begin: 0.1,
                                    end: 0,
                                    curve: Curves.easeOutQuad,
                                  ),
                              const SizedBox(height: 14),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppStrings.loginSubtitle.tr,
                                      style: AppTextStyles
                                          .ibmPlexSansSize16w500Primary
                                          .copyWith(
                                            color: AppColors.kWhite,
                                            fontSize: 16,
                                          ),
                                    ),
                                    TextSpan(
                                      text: 'ShipHub',
                                      style: AppTextStyles
                                          .ibmPlexSansSize17w700Neon
                                          .copyWith(
                                            color: AppColors.kNeonGreen,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 500.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            curve: Curves.easeOutQuad,
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
