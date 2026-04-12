import 'dart:io';

import 'package:flutter/material.dart';
import '../../translation/all_translation.dart';

import '../../theme/colors/styles.dart';
import '../blocs/main_app_bloc.dart';
import 'custom_images.dart';

class ArrowBack extends StatelessWidget {
  final Color color;
  final double? size;
  final bool? isRTL;

  const ArrowBack(
      {super.key, this.color = AppColors.kPrimary, this.isRTL, this.size});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isRTL != null && isRTL! ? 2 : 0,
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<String>(
          stream: mainAppBloc.langStream,
          builder: (context, snapshot) {
            if (allTranslations.currentLanguage == 'ar') {
              return customImageIconSVG(
                imageName: Platform.isIOS ? 'ios-left' : 'left',
                color: color,
                height: size,
                width: size,
              );
            } else {
              return customImageIconSVG(
                imageName: Platform.isIOS ? 'ios-right' : 'right',
                color: color,
                width: size,
                height: size,
              );
            }
          },
        ),
      ),
    );
  }
}
