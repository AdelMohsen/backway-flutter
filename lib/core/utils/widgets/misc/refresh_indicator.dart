import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';

class DefaultRefreshIndicatorWidget extends StatelessWidget {
  const DefaultRefreshIndicatorWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });
  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      onRefresh: onRefresh,
      backgroundColor: AppColors.kBlack,
      child: child,
    );
  }
}
