import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 7,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 65, // Adjust height as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(context, cubit, 0),
                  _buildNavItem(context, cubit, 1),

                  // Middle Space for FAB and Text
                  SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 25), // Space for FAB
                        Text(
                          mainAppBloc.isArabic
                              ? "إنشاء طلب فوري"
                              : "Create Order Now",
                          style: AppTextStyles.cairoW600Size8.copyWith(
                            color: const Color(0xFFA3A3A3), // Light Gray
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  _buildNavItem(context, cubit, 3),
                  _buildNavItem(context, cubit, 4),
                ],
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
        onTap: () => cubit.changeIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected ? item.activeIcon : item.icon,
            const SizedBox(height: 4),
            Text(
              item.label!,
              style: isSelected
                  ? AppTextStyles.ibmPlexSansSize10w700.copyWith(
                      color: AppColors.primaryGreenHub,
                    )
                  : AppTextStyles.ibmPlexSansSize10w400.copyWith(
                      color: Color.fromRGBO(179, 179, 179, 1),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
