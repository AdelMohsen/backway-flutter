import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import '../../logic/orders_cubit.dart';
import '../../logic/orders_state.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/orders_tab_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..loadOrders(),
      child: const OrderScreenContent(),
    );
  }
}

class OrderScreenContent extends StatelessWidget {
  const OrderScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        backgroundColor: AppColors.nutral07, // Light grey bg
        child: GradientHeaderLayout(
          showAction: false,
          title: AppStrings.myOrders.tr,
          child: Column(
            children: [
              const SizedBox(height: 20), // Space inside the card
              // Tabs
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return OrdersTabWidget(
                    selectedIndex: context.read<OrdersCubit>().selectedTabIndex,
                    onTabSelected: (index) {
                      context.read<OrdersCubit>().changeTab(index);
                    },
                  );
                },
              ),

              const SizedBox(height: 16),

              // List
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrdersLoaded) {
                      if (state.orders.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await context.read<OrdersCubit>().onRefresh();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: _buildEmptyWidget(),
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          await context.read<OrdersCubit>().onRefresh();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 40, top: 4),
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            return OrderCardWidget(
                              order: state.orders[index],
                              tabIndex: state.selectedTabIndex,
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: Text(
                        mainAppBloc.isArabic ? "لا يوجد طلبات" : "No orders",
                        style: AppTextStyles.cairoW400Size12.copyWith(
                          color: const Color.fromRGBO(187, 187, 187, 1),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildEmptyWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.ordersEmpty),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ليس لديك طلبات حاليا"
                  : "You have no orders currently",
              style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "قم بانشاء طلبك الان وستصلك عروض الأسعار قريبًا"
                  : "Create your order now, and you will receive price quotes soon.",
              style: AppTextStyles.ibmPlexSansSize14w600Black.copyWith(
                color: const Color.fromRGBO(153, 153, 153, 1),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
