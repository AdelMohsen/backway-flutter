import 'package:flutter/material.dart';

import '../../../navigation/custom_navigation.dart';
import '../../../theme/colors/styles.dart';

class ArrowButton extends StatelessWidget {
  void Function()? onTap;
  final Widget? icon;
  ArrowButton({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 255, 255, 0.8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child:
            icon ??
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary,
              size: 16,
            ),
      ),
    );
  }
}
