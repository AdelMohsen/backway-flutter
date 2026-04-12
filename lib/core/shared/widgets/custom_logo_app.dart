import 'package:flutter/material.dart';

import '../../assets/app_images.dart';

class CustomLogoApp extends StatelessWidget {
  var width;
  var height;
  CustomLogoApp({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: Text('Logo'));
  }
}
