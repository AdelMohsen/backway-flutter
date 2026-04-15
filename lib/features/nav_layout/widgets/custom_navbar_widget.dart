import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';

class CustomNavbarWidget extends StatelessWidget {
  const CustomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
      builder: (context, state) {
        final cubit = NavbarLayoutCubit.get(context);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    cubit.items.length,
                    (index) => _buildNavItem(context, cubit, index),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavbarLayoutCubit cubit,
    int index,
  ) {
    final isSelected = cubit.currentIndex == index;
    final item = cubit.items[index];

    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => cubit.changeIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected ? item.activeIcon : item.icon,
            const SizedBox(height: 6),
            Text(
              item.label ?? '',
              style: Styles.urbanistSize14w700White.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
                color: isSelected
                    ? ColorsApp.kPrimary
                    : const Color.fromRGBO(130, 134, 171, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
