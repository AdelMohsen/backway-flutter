import '../buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/entity/error_entity.dart';
import '../../extensions/extensions.dart';
import '../text/main_text.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.error, this.onPressed});
  final ErrorEntity error;
  final void Function()? onPressed;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainText(
              text: 'We apologize for the inconvenience!'.tr,
              // style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
              //     .copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const Stack(
              alignment: Alignment.center,
              children: [
                // SvgPicture.asset(AppSvg.winnerBackground),
                // MainText(
                //   text: widget.error.statusCode.toString(),
                //   style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
                //       .copyWith(fontSize: 14),
                //   textAlign: TextAlign.center,
                //   maxLines: 3,
                // ),
                Icon(Icons.info),
              ],
            ),
            MainText(
              text: widget.error.message,
              // style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
              //     .copyWith(fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            15.sbH,
            DefaultButton(text: 'reload again'.tr, onPressed: widget.onPressed),
          ],
        ).animate().fade(),
      ),
    );
  }
}
