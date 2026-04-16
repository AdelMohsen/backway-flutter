import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OnboardingBottomCard extends StatelessWidget {
  final VoidCallback onNextPressed;
  final int currentPage;
  final String titlePart1;
  final String titleHighlight;
  final String titlePart2;
  final String subtitle;
  final String? buttonText;
  final String? buttonIcon;

  const OnboardingBottomCard({
    Key? key,
    required this.onNextPressed,
    required this.currentPage,
    required this.titlePart1,
    required this.titleHighlight,
    required this.titlePart2,
    required this.subtitle,
    this.buttonText,
    this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsApp.kPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // It will tightly wrap children if embedded in a Stack
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(isActive: currentPage == 0),
                const SizedBox(width: 8),
                _buildIndicator(isActive: currentPage == 1),
                const SizedBox(width: 8),
                _buildIndicator(isActive: currentPage == 2),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Title
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Styles.urbanistSize28w500White.copyWith(height: 1.2),
              children: [
                if (titlePart1.isNotEmpty) TextSpan(text: titlePart1),
                if (titleHighlight.isNotEmpty)
                  TextSpan(
                    text: titleHighlight,
                    style: Styles.urbanistSize28w700Orange,
                  ),
                if (titlePart2.isNotEmpty) TextSpan(text: titlePart2),
              ],
            ),
          ).animate(key: ValueKey(titleHighlight)).fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 16),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.urbanistSize14w400White.copyWith(
              color: const Color.fromRGBO(222, 222, 222, 1),
            ),
          ).animate(key: ValueKey(subtitle)).fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 38), // Space before button
          // Next Button
          DefaultButton(
            height: 52,
            borderRadiusValue: 28,
            backgroundColor: ColorsApp.KorangePrimary,
            onPressed: onNextPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText ?? AppStrings.next.tr,
                  style: Styles.urbanistSize14w700White.copyWith(fontSize: 16),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  SvgImages.back, // Ensure this points to the right arrow icon
                ).animate(onPlay: (c) => c.repeat()).moveX(begin: 0, end: 3, duration: 600.ms, curve: Curves.easeInOut).then().moveX(begin: 0, end: -3, duration: 600.ms, curve: Curves.easeInOut),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 37 : 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
