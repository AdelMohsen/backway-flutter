import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

class AddressSectionWidget extends StatelessWidget {
  final TextEditingController? fromController;
  final TextEditingController? toController;
  final VoidCallback? onFromTap;
  final VoidCallback? onToTap;

  const AddressSectionWidget({
    Key? key,
    this.fromController,
    this.toController,
    this.onFromTap,
    this.onToTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            AppStrings.address.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dotted vertical line
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 60),
                child: Text(
                  AppStrings.from.tr,
                  style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 12),
          // Second row: From field with box icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: fromController?.text.isNotEmpty == true
                      ? AppColors.primaryGreenHub.withOpacity(0.1)
                      : const Color.fromRGBO(245, 245, 245, 1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppSvg.point,
                    color: fromController?.text.isNotEmpty == true
                        ? AppColors.primaryGreenHub
                        : null,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: onFromTap,
                  child: IgnorePointer(
                    child: DefaultFormField(
                      textAlign: TextAlign.start,
                      controller: fromController ?? TextEditingController(),
                      hintText: AppStrings.selectStartingPoint.tr,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(AppSvg.gps),
                      ),
                      hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey
                          .copyWith(
                            color: const Color.fromRGBO(152, 152, 152, 1),
                          ),
                      fillColor: const Color.fromRGBO(247, 247, 247, 1),
                      borderColor: const Color.fromRGBO(247, 247, 247, 1),
                      borderRadious: 25,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      needValidation: false,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Dotted line and إلى label row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dotted vertical line
              SizedBox(
                width: 48,
                child: Center(
                  child: CustomPaint(
                    size: Size(2, 60),
                    painter: _DottedLinePainter(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 14),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.to.tr,
                      style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
          // Third row: To field with location icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: toController?.text.isNotEmpty == true
                      ? AppColors.primaryGreenHub.withOpacity(0.1)
                      : const Color.fromRGBO(245, 245, 245, 1),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on_outlined,
                    color: toController?.text.isNotEmpty == true
                        ? AppColors.primaryGreenHub
                        : Color.fromRGBO(180, 180, 180, 1),
                    size: 22,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: onToTap,
                  child: IgnorePointer(
                    child: DefaultFormField(
                      textAlign: TextAlign.start,
                      controller: toController ?? TextEditingController(),
                      hintText: AppStrings.selectDestination.tr,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(AppSvg.gps),
                      ),
                      hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey
                          .copyWith(
                            color: const Color.fromRGBO(152, 152, 152, 1),
                          ),
                      fillColor: const Color.fromRGBO(247, 247, 247, 1),
                      borderColor: const Color.fromRGBO(247, 247, 247, 1),
                      borderRadious: 25,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      needValidation: false,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

// Custom painter for dotted vertical line
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(217, 217, 217, 1)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const double dashHeight = 3;
    const double dashSpace = 8;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
