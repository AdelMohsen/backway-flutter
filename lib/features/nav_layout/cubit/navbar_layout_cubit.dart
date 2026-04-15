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
      activeIcon: SvgPicture.asset(SvgImages.homeActive),
      icon: SvgPicture.asset(SvgImages.homeUnActive),
      label: AppStrings.home.tr,
      tooltip: AppStrings.home.tr,
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(SvgImages.truck),
      icon: SvgPicture.asset(SvgImages.truckUnActive),
      label: AppStrings.myOrders.tr,
      tooltip: AppStrings.myOrders.tr,
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(SvgImages.tagActive),
      icon: SvgPicture.asset(SvgImages.tagUnActive),
      label: AppStrings.negotiation.tr,
      tooltip: AppStrings.negotiation.tr,
    ),
    BottomNavigationBarItem(
      activeIcon: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/new/nn.png', height: 24, width: 24),
      ),
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/new/nn.png', height: 24, width: 24),
      ),
      label: 'profile'.tr,
      tooltip: 'profile'.tr,
    ),
  ];

  List<Widget> pages = [
    const HomeScreen(),
    const OrderScreen(),
    const OffersScreen(),
    const MoreScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(state.copyWith(currentIndex: index));
  }
}
