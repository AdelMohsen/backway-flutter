import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';
import '../widgets/custom_navbar_widget.dart';

class CustomNavbarLayoutMobilePortraitDesignScreen extends StatefulWidget {
  const CustomNavbarLayoutMobilePortraitDesignScreen({super.key});

  @override
  State<CustomNavbarLayoutMobilePortraitDesignScreen> createState() =>
      _CustomNavbarLayoutMobilePortraitDesignScreenState();
}

class _CustomNavbarLayoutMobilePortraitDesignScreenState
    extends State<CustomNavbarLayoutMobilePortraitDesignScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        final cubit = NavbarLayoutCubit.get(context);
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) =>
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  systemNavigationBarDividerColor: Colors.transparent,
                ),
                child: CustomScaffoldWidget(
                  needAppbar: false,
                  backgroundColor: AppColors.kWhite,
                  bottomNavigationBar: const CustomNavbarWidget(),
                  child: cubit.pages[cubit.currentIndex],
                ),
              ),
        );
      },
    );
  }
}
