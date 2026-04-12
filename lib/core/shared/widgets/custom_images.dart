import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/colors/styles.dart';
import '../../utils/extensions/extensions.dart';

Widget customImageIcon({
  String? folderPath,
  required String? imageName,
  String? imagePath,
  double? width,
  double? height,
  color,
}) {
  return Image.asset(
    'assets/${folderPath ?? "images"}/$imageName.${imagePath ?? "png"}',
    color: color,
    width: width ?? 30,
    height: height ?? 25,
  );
}

Widget customCircleSvgIcon(
    {String? folderPath,
    String? title,
    required String? imageName,
    String? imagePath,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return GestureDetector(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color ?? AppColors.kPrimary.withOpacity(0.1),
          radius: radius ?? 24,
          child: SvgPicture.asset(
            'assets/svgs/$folderPath/$imageName.svg',
          ),
        ),
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              2.sbH,
              Text(
                title ?? '',
                style: const TextStyle(
                    color: AppColors.kPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customImageIconSVG({
  required String? imageName,
  Color? color,
  double? height,
  double? width,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(
      'assets/svgs/$imageName.svg',
      color: color,
      width: width,
      height: height,
    ),
  );
}
