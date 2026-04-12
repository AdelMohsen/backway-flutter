import 'package:flutter/material.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

class GradientHeaderLayout extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? action;
  final Widget? logo;
  final Color? backgroundColor;

  /// 🔹 NEW
  final bool showTitle;
  final bool showAction;
  final double headerHeight;
  final Widget? trailing;
  final TextStyle? style;

  const GradientHeaderLayout({
    super.key,
    this.title,
    required this.child,
    this.logo,
    this.showTitle = true,
    this.style,
    this.showAction = true,
    this.action,
    this.headerHeight = 180,
    this.backgroundColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Gradient Header
        Container(
          height: headerHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.kLightGreen, AppColors.primaryGreenHub],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),

        // 🔹 Header Content
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showAction
                      ? InkWell(
                          onTap: () {
                            CustomNavigator.pop();
                          },
                          child:
                              (action ??
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.23),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: AppColors.kWhite,
                                  size: 17,
                                ),
                              )),
                        )
                      : const SizedBox(width: 40),

                  showTitle
                      ? logo ??
                            Text(
                              title ?? "",
                              style:
                                  style ??
                                  AppTextStyles.ibmPlexSansSize26w700White,
                            )
                      : const SizedBox.shrink(),
                  trailing ?? const SizedBox(width: 44),
                ],
              ),
            ),
          ),
        ),

        // 🔹 Glass effect layer
        Padding(
          padding: const EdgeInsets.only(top: 117, left: 4, right: 4),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(128),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),

        // 🔹 Main Content Card
        Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.kWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
