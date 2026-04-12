import 'package:flutter/material.dart';

class LogoLoadingWidget extends StatelessWidget {
  const LogoLoadingWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.email)
        //  Image.asset(
        //   AppImages.earthIcon3D,
        //   height: height ?? 100,
        //   width: width ?? 100,
        // ),
        );
  }
}
