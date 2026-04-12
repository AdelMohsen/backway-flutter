import 'package:flutter/material.dart';
import '../../../shared/entity/error_entity.dart';
import '../../../theme/colors/styles.dart';
import '../text/main_text.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({super.key, this.message, this.onTap, this.error});
  final String? message;
  final void Function()? onTap;
  final ErrorEntity? error;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: MainText(
            text: error?.message ?? message ?? '',
            fontSize: 12,
            color: AppColors.kBlack,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
