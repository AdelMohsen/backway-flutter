import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/carrier_name_price.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/carrier_rating.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/carriers_card_single.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/count_carriers_filtter_button.dart';

class ListCarriersWidget extends StatelessWidget {
  final int step;
  final VoidCallback onNextStep;

  const ListCarriersWidget({
    Key? key,
    required this.step,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CarriersListHeader(carrierCount: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return const CarrierCard();
            },
          ),
        ),
        NextStepButton(step: step, onNextStep: onNextStep),
      ],
    );
  }
}

/// Header widget displaying carrier count and filter button
class CarriersListHeader extends StatelessWidget {
  final int carrierCount;

  const CarriersListHeader({Key? key, required this.carrierCount})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(2, 4),
            blurRadius: 4,
          ),
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadiusDirectional.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.carriersCountTitle.tr,
                  style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
                    color: Color.fromRGBO(29, 34, 77, 1),
                  ),
                ),
                const SizedBox(width: 8),
                CarrierCountBadge(count: carrierCount),
              ],
            ),
            const FilterButton(),
          ],
        ),
      ),
    );
  }
}

class CarrierInfoRow extends StatelessWidget {
  final String name;
  final int price;
  final double rating;

  const CarrierInfoRow({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImages.imageCarriers, width: 48, height: 48),
        SizedBox(width: 12),
        CarrierNameAndPrice(name: name, price: price.toString()),
        const Spacer(),
        CarrierRatingBadge(rating: rating),
      ],
    );
  }
}

/// Badge displaying carrier rating

/// Bottom "Next" button
class NextStepButton extends StatelessWidget {
  final int step;
  final VoidCallback onNextStep;

  const NextStepButton({Key? key, required this.step, required this.onNextStep})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: DefaultButton(
        onPressed: onNextStep,
        width: double.infinity,
        height: 56,
        borderRadius: BorderRadius.circular(44),
        child: Center(
          child: Text(
            AppStrings.next.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
