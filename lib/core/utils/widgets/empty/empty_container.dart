import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../extensions/media_query_helper.dart';
import '../../../theme/colors/styles.dart';
import '../../extensions/extensions.dart';

import '../text/main_text.dart';

class EmptyContainer extends StatelessWidget {
  final String? img;
  final String? txt;
  final String? subText;
  final double? remain;
  final TextStyle? subStyle;

  const EmptyContainer({
    super.key,
    this.img,
    this.txt,
    this.remain = 0.0,
    this.subText,
    this.subStyle,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height - remain!,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                img ?? 'assets/svgs/empty-image.svg',
                width: MediaQueryHelper.width * .8,
              ),
              40.sbH,
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  txt ?? 'No Data Yet !'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              10.sbH,
              MainText(
                text: subText ?? '',
                textAlign: TextAlign.center,
                style: subStyle ?? const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
