import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/assets/app_svg.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/theme/colors/styles.dart';
import '../../offers/ui/pages/offers_screen.dart';
import '../../home/ui/pages/home_screen.dart';
import '../../more/ui/pages/more_screen.dart';
import '../../orders/ui/pages/order_screen.dart';
import 'navbar_layout_state.dart';

class NavbarLayoutCubit extends Cubit<NavbarLayoutState> {
  NavbarLayoutCubit() : super(const NavbarLayoutState());

  static NavbarLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> get items => [
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(AppSvg.homeNav),
      icon: SvgPicture.asset(AppSvg.homeNavInactive),
      label: AppStrings.home.tr,
      tooltip: AppStrings.home.tr,
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        AppSvg.offersNav,
        color: AppColors.primaryGreenHub,
      ),
      icon: SvgPicture.asset(AppSvg.offersNav, color: AppColors.nutral60),
      label: AppStrings.offers.tr,
      tooltip: AppStrings.offers.tr,
    ),

    const BottomNavigationBarItem(
      activeIcon: Icon(
        CupertinoIcons.add_circled,
        color: AppColors.primaryGreenHub,
      ),
      icon: Icon(CupertinoIcons.add_circled, color: AppColors.primaryGreenHub),
      label: '',
      tooltip: '',
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        AppSvg.ordersNav,
        color: AppColors.primaryGreenHub,
      ),
      icon: SvgPicture.asset(AppSvg.ordersNav, color: AppColors.nutral60),
      label: AppStrings.myOrders.tr,
      tooltip: AppStrings.myOrders.tr,
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        AppSvg.moreNav,
        colorFilter: const ColorFilter.mode(
          AppColors.primaryGreenHub,
          BlendMode.srcIn,
        ),
      ),

      icon: SvgPicture.asset(AppSvg.moreNav, color: AppColors.nutral60),
      label: AppStrings.more.tr,
      tooltip: AppStrings.more.tr,
    ),
  ];

  List<Widget> pages = [
    const HomeScreen(),
    const OffersScreen(),
    const SizedBox(),
    const OrderScreen(),
    const MoreScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(state.copyWith(currentIndex: index));
  }
}
