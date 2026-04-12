import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/widgets/custom_paint_slider.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/features/new_order/ui/widgets/carriers_widget/filter_bottom_sheet.dart';

/// Badge displaying the number of carriers
class CarrierCountBadge extends StatelessWidget {
  final int count;

  const CarrierCountBadge({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromRGBO(186, 220, 88, 1),
      ),
      child: Center(
        child: Text(
          '$count',
          style: AppTextStyles.ibmPlexSansSize9w700White.copyWith(
            color: Color.fromRGBO(34, 34, 34, 1),
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}

/// Filter button widget
class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(context),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Color.fromRGBO(237, 246, 245, 1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.tune,
          color: AppColors.primaryGreenHub,
          size: 14,
        ),
      ),
    );
  }
}

/// Filter Bottom Sheet Widget
