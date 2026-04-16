import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => CustomNavigator.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6F8FA),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      SvgImages.kBackIcon,
                      colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(36, 35, 39, 1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "aa",
                    textAlign: TextAlign.center,
                    style: Styles.urbanistSize16w600White.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 44), // To balance the row visually
              ],
            ),
          ],
        ),
      ),
    );
  }
}
