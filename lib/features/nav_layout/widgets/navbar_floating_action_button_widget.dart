import 'package:flutter/material.dart';
import 'package:greenhub/features/choice_type_order/ui/widgets/choice_type_order_bottom_sheet.dart';
import '../../../core/theme/colors/styles.dart';

class NavbarFloatingActionButtonWidget extends StatelessWidget {
  const NavbarFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // The FAB itself (Green Circle)
    return GestureDetector(
      onTap: () {
        ChoiceTypeOrderBottomSheet.show(context);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primaryGreenHub,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ), // Optional white border effect
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreenHub.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(2, 10),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(
            183,
            232,
            61,
            1,
          ), // Or a lighter green as per image? Image shows yellow/light green plus
          size: 32,
        ),
      ),
    );
  }
}
