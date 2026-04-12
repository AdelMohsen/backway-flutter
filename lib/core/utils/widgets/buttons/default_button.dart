import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/app_text_height_styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../text/main_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.child,
    this.onPressed,
    this.padding,
    this.borderAll,
    this.text,
    this.borderRadiusValue = 10,
    this.fontSize,
    this.elevation,
    this.side,
    this.textColor,
    this.isLoading = false,
    this.fontWeight,
    this.height,
    this.width,
    this.borderWidth,
    this.maxheight,
    this.maxwidth,
    this.textStyle,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Color? borderAll;
  final String? text;
  final Widget? child;
  final double? borderRadiusValue;
  final double? fontSize;
  final double? elevation;
  final WidgetStateProperty<BorderSide?>? side;
  final Color? textColor;
  final bool isLoading;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? maxheight;
  final double? maxwidth;
  final double? borderWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onPressed ?? () {},
      child: Container(
        height: height ?? 45,
        width: width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          border: Border.all(color: borderAll ?? Colors.transparent),

          borderRadius:
              borderRadius ?? BorderRadius.circular(borderRadiusValue ?? 10),
          color: borderColor ?? backgroundColor ?? AppColors.kPrimary,
        ),
        child:
            child ??
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainText(
                    text: text ?? AppStrings.login.tr,
                    style: textStyle ?? AppTextStyles.cairoW700Size20,
                  ),
                  if (isLoading)
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 20,
                    ),
                ],
              ),
            ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //     boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
    //   ),
    //   child: ElevatedButton(
    //     onPressed: isLoading ? () {} : onPressed ?? () {},
    //     style: ButtonStyle(
    //       backgroundColor: WidgetStateProperty.all(
    //         backgroundColor ?? AppColors.kPrimary,
    //       ),
    //       side: side,
    //       minimumSize: WidgetStateProperty.all(
    //         Size(width ?? MediaQuery.of(context).size.width, height ?? 45),
    //       ),
    //       padding: WidgetStateProperty.all(
    //         padding ?? const EdgeInsets.symmetric(horizontal: 5),
    //       ),
    //       elevation: WidgetStateProperty.all(elevation ?? 0),
    //       visualDensity: const VisualDensity(horizontal: .9, vertical: .8),
    //       foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    //       shape: WidgetStateProperty.all(
    //         RoundedRectangleBorder(
    //           borderRadius:
    //               borderRadius ??
    //               BorderRadius.circular(borderRadiusValue ?? 24),
    //           side: BorderSide(
    //             color: borderColor ?? backgroundColor ?? AppColors.kPrimary,
    //             width: borderWidth ?? 1,
    //           ),
    //         ),
    //       ),
    //     ),
    //     child:
    //         child ??
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Text(
    //               text ?? 'LOGIN',
    //               style:
    //                   textStyle ??
    //                   AppTextStyles.bodySmMedium.copyWith(color: textColor),
    //             ),
    //             if (isLoading)
    //               LoadingAnimationWidget.staggeredDotsWave(
    //                 color: Colors.white,
    //                 size: 20,
    //               ),
    //           ],
    //         ),
    //   ),
    // );
  }
}
