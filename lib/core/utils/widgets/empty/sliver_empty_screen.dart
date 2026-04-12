import 'package:flutter/material.dart';

import '../text/main_text.dart';
import '../../../theme/colors/styles.dart';
import '../misc/customer_scroll_behaviour.dart';
import '../responsive/responsive.dart';

class SliverEmptyScreen extends StatelessWidget {
  const SliverEmptyScreen({super.key, required this.onRefresh, this.text});
  final Future<void> Function() onRefresh;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 6),
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
                  child: const Icon(Icons.hourglass_empty),
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
                  text: text ?? 'AppStrings.noDataFound',
                  textAlign: TextAlign.center,
                  fontSize: Responsive.isLarge(context)
                      ? 25
                      : Responsive.isMedium(context)
                      ? 20
                      : 15,
                  maxLines: 1,
                  color: AppColors.kPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
