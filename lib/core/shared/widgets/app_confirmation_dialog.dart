import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../assets/app_svg.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/text_styles.dart';

class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final String? iconPath;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.confirmColor,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child:
          Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconPath != null) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (confirmColor ?? AppColors.kRed).withOpacity(
                              0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            iconPath!,
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                              confirmColor ?? AppColors.kRed,
                              BlendMode.srcIn,
                            ),
                          ),
                        ).animate().scale(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutBack,
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.ibmPlexSansSize18w700Primary
                            .copyWith(color: AppColors.kBlack),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.ibmPlexSansSize14w400Grey,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(44),
                                  border: Border.all(color: AppColors.nutral60),
                                ),
                                child: Center(
                                  child: Text(
                                    cancelText,
                                    style: AppTextStyles
                                        .ibmPlexSansSize14w600Black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                onConfirm();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: confirmColor ?? AppColors.kRed,
                                  borderRadius: BorderRadius.circular(44),
                                ),
                                child: Center(
                                  child: Text(
                                    confirmText,
                                    style: AppTextStyles
                                        .ibmPlexSansSize14w600White,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fade(duration: const Duration(milliseconds: 200))
              .scale(
                begin: const Offset(0.9, 0.9),
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
              ),
    );
  }
}
