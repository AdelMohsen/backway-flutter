import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class TrackShipmentHeader extends StatelessWidget {
  const TrackShipmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => CustomNavigator.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(175, 175, 175, 0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: mainAppBloc.isArabic ? math.pi : 0,
                  child: SvgPicture.asset(
                    SvgImages.kBackIcon,
                    colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(36, 35, 39, 1),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                "tracking",
                textAlign: TextAlign.center,
                style: Styles.urbanistSize20w700Orange.copyWith(
                  color: ColorsApp.kPrimary,
                ),
              ),
            ),
            const SizedBox(width: 44), // Spacer to center the title
          ],
        ),
      ),
    );
  }
}
