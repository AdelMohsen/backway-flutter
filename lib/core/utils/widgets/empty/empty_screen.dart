import 'package:flutter/material.dart';

import '../../../shared/widgets/title_with_back_arrorw_widget.dart';
import '../text/main_text.dart';
import '../../../theme/colors/styles.dart';
import '../misc/customer_scroll_behaviour.dart';
import '../responsive/responsive.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.onRefresh,
    this.text,
    this.needIcon = true,
    this.needBackButton = true,
  });
  final Future<void> Function() onRefresh;
  final String? text;
  final bool? needIcon;
  final bool needBackButton;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          shrinkWrap: true,
          children: [
            if (needBackButton) const TitleWithBackArrorwWidget(title: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            if (needIcon == true)
              Center(
                child: SizedBox(
                  height: Responsive.isLarge(context)
                      ? MediaQuery.of(context).size.height / 6
                      : Responsive.isMedium(context)
                          ? MediaQuery.of(context).size.height / 4
                          : MediaQuery.of(context).size.height / 3.5,
                  width: Responsive.isLarge(context)
                      ? MediaQuery.of(context).size.width / 5
                      : Responsive.isMedium(context)
                          ? MediaQuery.of(context).size.width / 3
                          : MediaQuery.of(context).size.width / 2.5,
                  child: const Icon(Icons.emoji_people),
                ),
              ),
            SizedBox(
              height: Responsive.isLarge(context)
                  ? 40
                  : Responsive.isMedium(context)
                      ? 30
                      : 20,
            ),
            Center(
              child: MainText(
                text: text ?? 'AppStrings.noDataFound.tr',
                textAlign: TextAlign.center,
                fontSize: Responsive.isLarge(context)
                    ? 25
                    : Responsive.isMedium(context)
                        ? 20
                        : 15,
                maxLines: 1,
                color: AppColors.kBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
