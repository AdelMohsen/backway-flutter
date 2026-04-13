import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/onboarding/ui/widgets/onboarding_bottom_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsApp.kPrimary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ColorsApp.KorangePrimary,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [_buildPage1(), _buildPage2(), _buildPage3()],
            ),

            // Skip Button in Top Right (hidden on last page)
            if (_currentPage < 2)
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      right: 16,
                      left: 16,
                    ),
                    child: _buildSkipButton(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    return Stack(
      children: [
        // 1. Tooltips that appear BEHIND the driver
        _buildTooltip(
          AppStrings.chooseClosestDriver.tr,
          top: MediaQuery.of(context).padding.top + 110,
          left: 16,
        ),

        // 2. Driver Image
        Positioned(
          top: MediaQuery.of(context).padding.top + 90,
          left: 24,
          right: 24,
          bottom: 290,
          child: Image.asset(
            ImagesApp.onboadringDriver,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),

        // 3. Tooltips that appear IN FRONT of the driver
        _buildTooltip(AppStrings.deliveredShipment.tr, bottom: 420, left: 16),
        _buildTooltip(
          AppStrings.trackShipment.tr,
          top: MediaQuery.of(context).padding.top + 270,
          right: 16,
        ),

        // Bottom Information Card
        Align(
          alignment: Alignment.bottomCenter,
          child: OnboardingBottomCard(
            currentPage: 0,
            titlePart1: AppStrings.receiveWorldAt.tr,
            titleHighlight: AppStrings.doorstep.tr,
            titlePart2: '',
            subtitle: AppStrings.enterTrackingNumber.tr,
            onNextPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPage2() {
    return Stack(
      children: [
        // Ribbons background (behind phone)
        Positioned(
          top: MediaQuery.of(context).padding.top + 390,
          right: -45,
          child: Image.asset(
            ImagesApp.vec1,
            height: 200, // Subtle accent
          ),
        ),

        // 2. Second Onboarding Image (Phone)
        Positioned(
          top: 140,
          left: 10,
          right: 24,
          bottom: 80,
          child: Image.asset(
            ImagesApp.cc,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),

        // Ribbon on top of phone
        Positioned(
          top: MediaQuery.of(context).padding.top + 160,
          left: -1,
          child: Image.asset(ImagesApp.vec2, height: 111),
        ),

        // Shadow overlay on top of the phone
        Positioned(
          top: MediaQuery.of(context).padding.top + 190,
          left: 10,
          right: 10,
          bottom: 20,
          child: Image.asset(
            ImagesApp.shadow,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),

        // Bottom Information Card
        Align(
          alignment: Alignment.bottomCenter,
          child: OnboardingBottomCard(
            currentPage: 1,
            titlePart1: AppStrings.getYour.tr,
            titleHighlight: AppStrings.package.tr,
            titlePart2: AppStrings.deliveredSafely.tr,
            subtitle: AppStrings.upToThreeStops.tr,
            onNextPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPage3() {
    return Stack(
      children: [
        // Onboarding 3 Image (driver with phone)
        Positioned(
          left: 50,
          right: 50,
          bottom: 370,
          child: Image.asset(
            ImagesApp.onboarding3,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),

        // Verified badge icon at bottom-right of the driver
        Positioned(
          bottom: 380,
          right: 50,
          child: Container(
            padding: const EdgeInsets.all(10),

            child: SvgPicture.asset(SvgImages.on3, width: 60, height: 60),
          ),
        ),

        // Bottom Information Card
        Align(
          alignment: Alignment.bottomCenter,
          child: OnboardingBottomCard(
            currentPage: 2,
            titleHighlight: AppStrings.delivery.tr,
            titlePart1: '',
            titlePart2: AppStrings.byVerifiedUsers.tr,
            subtitle: AppStrings.enterTrackingNumber.tr,
            buttonText: AppStrings.signIn.tr,
            buttonIcon: SvgImages.on3,
            onNextPressed: () {
              CustomNavigator.push(Routes.CHOOSE_ACCOUNT);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTooltip(
    String text, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: ColorsApp.kTooltipBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Styles.urbanistSize16w600White.copyWith(
            fontSize: 12,
            color: ColorsApp.kPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(Routes.CHOOSE_ACCOUNT);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.skip.tr,
              style: Styles.urbanistSize16w500White.copyWith(fontSize: 14),
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(SvgImages.backs, width: 14, height: 14),
          ],
        ),
      ),
    );
  }
}
