import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class OrdersTabWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const OrdersTabWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color.fromRGBO(237, 246, 245, 1), width: 1),
      ),
      child: Row(
        children: [
          _buildTabItem(0, AppStrings.scheduled.tr),
          _buildTabItem(1, AppStrings.inTransit.tr),
          _buildTabItem(2, AppStrings.previous.tr),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          margin: const EdgeInsets.all(7),

          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 1,
            ),
            color: isSelected
                ? Color.fromRGBO(237, 246, 245, 1)
                : Colors.transparent, // Very light green bg
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: isSelected
                      ? AppTextStyles.ibmPlexSansSize16w600Primary
                      : AppTextStyles.ibmPlexSansSize16w600Grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
