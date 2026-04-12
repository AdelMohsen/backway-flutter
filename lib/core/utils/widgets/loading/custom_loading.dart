import '../../../theme/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../extensions/media_query_helper.dart';
import '../../../theme/colors/styles.dart';

class CustomLoading extends StatelessWidget {
  final bool? loading;
  final margin;
  final color;
  final value;
  final double? remain;
  final double? height;
  final bool isTextLoading;

  const CustomLoading({
    super.key,
    this.loading,
    this.margin,
    this.isTextLoading = false,
    this.color,
    this.value,
    this.remain = 0.0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (isTextLoading) {
      return Visibility(
        visible: loading ?? true,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Loading ... ', style: AppTextStyles.bodySmMedium),
              ],
            ),
          ),
        ),
      );
    } else {
      return Visibility(
        visible: loading ?? true,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQueryHelper.appMediaQueryViewPadding.bottom,
          ),
          child: SizedBox(
            height: height ?? MediaQueryHelper.height - remain!,
            child: Center(
              child: CircularProgressIndicator(
                color: color ?? AppColors.kPrimary,
              ),
            ),
          ),
        ),
      );
    }
  }
}
