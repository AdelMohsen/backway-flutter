import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/widgets/text/main_text.dart';
import 'custom_back_icon.dart';

class TitleWithBackArrorwWidget extends StatelessWidget {
  const TitleWithBackArrorwWidget({
    super.key,
    required this.title,
    this.needBackButton = true,
    //default 20
    this.titleFontSize,
    this.onPressed,
  });
  final String title;
  final bool needBackButton;
  final double? titleFontSize;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: AlignmentDirectional.center,
          child: MainText(
            text: title,
            // style: AppTextStyles.balooBhaijaan2W700Size20Primary1000.copyWith(
            //   fontSize: titleFontSize ?? 20,
            // ),
          ),
        ),
        if (needBackButton)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: CustomBackIcon(onPressed: onPressed),
          ),
        // if (context.read<CreateCustomGameQuestionCubit>().params.fromEditFlow)
        //   Align(
        //     alignment: AlignmentDirectional.centerEnd,
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: const CircleAvatar(
        //         backgroundColor: AppColors.kOpacityGrey2,
        //         child: Icon(
        //           CupertinoIcons.plus,
        //           color: AppColors.kWhite,
        //         ),
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
