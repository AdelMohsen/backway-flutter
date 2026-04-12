import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/extensions/extensions.dart';
import '../../utils/widgets/loading/adaptive_cirluer_progress.dart';
import '../../utils/widgets/text/main_text.dart';

class CustomOverlayLoadingWidget extends StatelessWidget {
  const CustomOverlayLoadingWidget({
    super.key,
    this.text,
  });
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AdaptiveCircularProgress(),
            40.sbH,
            MainText(
              text: text ?? 'AppStrings.loading.tr',
              // style: AppTextStyles.balooBhaijaan2W400Size16kPrimary700.copyWith(
              //   color: AppColors.kBlack,
              //   fontSize: 16,
              // ),
              textAlign: TextAlign.center,
            ).animate().fade()
          ],
        ),
      ),
    );
  }
}
