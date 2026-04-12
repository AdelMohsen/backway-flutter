import 'package:flutter/material.dart';

import '../text/main_text.dart';
import '../responsive/responsive.dart';

class SliverEmptyWidget extends StatelessWidget {
  const SliverEmptyWidget({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_empty),
              MainText(
                text: text ?? 'AppStrings.noDataFound',
                textAlign: TextAlign.center,
                fontSize: Responsive.isLarge(context)
                    ? 25
                    : Responsive.isMedium(context)
                        ? 20
                        : 15,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
