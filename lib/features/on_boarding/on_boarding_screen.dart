import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/shared/cache/cache_methods.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<Map<String, dynamic>> get pages => [
    {
      'image': AppImages.onBoarding3,
      'line1': [
        {'text': AppStrings.onboardingTitle1Part1.tr, 'highlight': false},
        {'text': AppStrings.onboardingTitle1Part2.tr, 'highlight': true},
      ],
      'line2': AppStrings.onboardingLine2Page1.tr,
      'line2Highlight': false,
      'useGoogleFont': false,
      'desc': AppStrings.onboardingDesc1.tr,
    },
    {
      'image': AppImages.onBoarding1,
      'line1': [
        {'text': AppStrings.onboardingTitle2Part1.tr, 'highlight': false},
        {'text': AppStrings.onboardingTitle2Part2.tr, 'highlight': true},
      ],
      'line2': AppStrings.onboardingLine2Page2.tr,
      'line2Highlight': false,
      'useGoogleFont': true,
      'desc': AppStrings.onboardingDesc2.tr,
    },
    {
      'image': AppImages.onBoarding2,
      'line1': [
        {'text': AppStrings.onboardingTitle3.tr, 'highlight': true},
      ],
      'line2': AppStrings.onboardingLine2Page3.tr,
      'line2Highlight': false,
      'useGoogleFont': true,
      'desc': AppStrings.onboardingDesc3.tr,
    },
  ];

  Future<void> _finishOnBoarding() async {
    await CacheMethods.saveOnBoarding();
    if (!mounted) return;

    final token = await CacheMethods.getToken();
    if (token != null && token.isNotEmpty) {
      CustomNavigator.push(Routes.CHOICE_ACCOUNT);
    } else {
      CustomNavigator.push(Routes.CHOICE_ACCOUNT);
    }
  }

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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            /// الصفحات
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (context, index) {
                return _buildPage(pages[index], index);
              },
            ),

            /// Progress + X
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(child: _buildProgressBars()),
                  const SizedBox(width: 12),
                  _buildCloseButton(),
                ],
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 40,
              child: InkWell(
                onTap: () {
                  if (currentIndex < pages.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _finishOnBoarding();
                  }
                },
                child: DefaultButton(
                  height: 56,
                  borderRadius: BorderRadius.circular(28),
                  text: AppStrings.onboardingNext.tr,
                  textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                      .copyWith(color: AppColors.kWhite),
                  onPressed: () {
                    if (currentIndex < pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _finishOnBoarding();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        _finishOnBoarding();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close, color: Colors.white),
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> page, int index) {
    final line1Parts = page['line1'] as List<Map<String, dynamic>>;
    final line2 = page['line2'] as String;
    final line2Highlight = page['line2Highlight'] as bool;
    final useGoogleFont = page['useGoogleFont'] as bool;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double pageValue = 0.0;
        if (_controller.position.haveDimensions) {
          pageValue = _controller.page ?? 0.0;
        }

        // Calculate the difference from current page
        double diff = (index - pageValue).abs();

        // Apply easing curve for smoother feel
        double easedDiff = Curves.easeOutCubic.transform(diff.clamp(0.0, 1.0));

        // Animation values - slide up from bottom
        double slideOffset =
            easedDiff * 100; // Larger slide distance for dramatic effect
        double opacity = (1 - easedDiff).clamp(0.0, 1.0);

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(page['image'], fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(10),
                    Colors.black.withAlpha(10),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 140,
              child: Transform.translate(
                offset: Offset(0, slideOffset),
                child: Opacity(
                  opacity: opacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Line 1 with mixed colors
                      RichText(
                        textAlign: mainAppBloc.isArabic
                            ? TextAlign.center
                            : TextAlign.left,
                        text: TextSpan(
                          children: line1Parts.map((part) {
                            return TextSpan(
                              text: part['text'],
                              style: useGoogleFont
                                  ? GoogleFonts.ibmPlexSansArabic(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: part['highlight']
                                          ? AppColors.kNeonGreen
                                          : Colors.white,
                                      height: 1.3,
                                    )
                                  : TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w400,
                                      color: part['highlight']
                                          ? AppColors.kNeonGreen
                                          : Colors.white,
                                      height: 1.3,
                                      fontFamily: 'MadaniArabic',
                                    ),
                            );
                          }).toList(),
                        ),
                      ),
                      // Line 2
                      Text(
                        line2,
                        textAlign: mainAppBloc.isArabic
                            ? TextAlign.center
                            : TextAlign.left,
                        style: useGoogleFont
                            ? GoogleFonts.ibmPlexSansArabic(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: line2Highlight
                                    ? AppColors.kNeonGreen
                                    : Colors.white,
                                height: 1.3,
                              )
                            : TextStyle(
                                fontSize: 40,
                                fontFamily: 'MadaniArabic',
                                fontWeight: FontWeight.w700,
                                color: line2Highlight
                                    ? AppColors.kNeonGreen
                                    : Colors.white,
                                height: 1.3,
                              ),
                      ),
                      const SizedBox(height: 18),
                      // Description
                      Text(
                        page['desc'],
                        textAlign: TextAlign.start,
                        style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.nutral10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Progress Bar
  Widget _buildProgressBars() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final page = _controller.hasClients ? _controller.page ?? 0.0 : 0.0;

        return Row(
          children: List.generate(pages.length, (i) {
            double progress;
            if (page >= i + 1) {
              progress = 1;
            } else if (page >= i) {
              progress = 1; // Current page should be fully filled
            } else {
              progress = 0;
            }

            return Expanded(
              child: Container(
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: currentIndex == 0
                          ? AppColors.kWhite
                          : AppColors.kWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
