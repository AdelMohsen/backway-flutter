import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';

class AdaptiveCircularProgress extends StatelessWidget {
  const AdaptiveCircularProgress({super.key, this.backgroundColor});
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: backgroundColor,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.kPrimary100),
      ),
    );
  }
}
