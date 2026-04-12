import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation/custom_navigation.dart';
import '../../theme/colors/styles.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({
    super.key,
    this.radius = 24,
    this.onPressed,
  });
  final double radius;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: IconButton(
        icon: Platform.isIOS
            ? const Icon(
                CupertinoIcons.back,
                color: AppColors.kBlack,
              )
            : const Icon(
                Icons.arrow_forward,
                color: AppColors.kBlack,
              ),
        onPressed: onPressed ??
            () {
              CustomNavigator.pop();
            },
      ),
    );
  }
}
