import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/form_fields/search_field_widget.dart';
import 'package:greenhub/features/shipments/ui/widgets/shipment_card.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key});

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ["New", "In Progress", "Completed", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorsApp.KorangePrimary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),

      child: CustomScaffoldWidget(
        needAppbar: false,
        backgroundColor: ColorsApp.KorangePrimary,
        child: Column(
          children: [
            Expanded(
              child: GradientHeaderLayout(
                showAction: false,
                title: "Shipments",
                headerColor: ColorsApp.KorangePrimary,
                headerHeight: 40,
                contentTopPadding: 110,
                style: Styles.urbanistSize20w700Orange.copyWith(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      // Tab Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(249, 250, 251, 1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color.fromRGBO(243, 244, 246, 1),
                            ),
                          ),
                          child: Row(
                            children: List.generate(
                              _tabs.length,
                              (index) => Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedTab = index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _selectedTab == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(100),
                                      border: _selectedTab == index
                                          ? Border.all(
                                              color: const Color.fromRGBO(
                                                136,
                                                136,
                                                136,
                                                0.2,
                                              ),
                                              width: 0.5,
                                            )
                                          : null,
                                      boxShadow: _selectedTab == index
                                          ? [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.05,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 1),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      _tabs[index],
                                      style: Styles.urbanistSize12w600Orange
                                          .copyWith(
                                            color: _selectedTab == index
                                                ? ColorsApp.kPrimary
                                                : const Color.fromRGBO(
                                                    156,
                                                    163,
                                                    175,
                                                    1,
                                                  ),
                                            fontWeight: _selectedTab == index
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SearchFieldWidget(
                          hintText: "Search by ID",
                          height: 48,
                          borderRadius: 100,
                          textAlign: TextAlign.left,
                          fillColor: const Color.fromRGBO(249, 250, 251, 1),
                          borderColor: const Color.fromRGBO(243, 244, 246, 1),
                          hintStyle: Styles.urbanistSize12w500Orange.copyWith(
                            color: const Color.fromRGBO(180, 183, 196, 1),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(14),
                            child: SvgPicture.asset(SvgImages.search),
                          ),
                          textStyle: Styles.urbanistSize12w500Orange.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Shipment List
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ShipmentCard(
                              orderId: "28765543",
                              vehicleType: "Cargo Van",
                              fromAddress: "Toronto, ON · M5V 2H1",
                              toAddress: "Vancouver, BC · V6B 3K9",
                              status: _tabs[_selectedTab].toLowerCase() ==
                                      'in progress'
                                  ? (index == 0
                                      ? 'Picking Up'
                                      : 'In Progress')
                                  : _tabs[_selectedTab],
                              progress: _tabs[_selectedTab].toLowerCase() ==
                                      'in progress'
                                  ? 0.75
                                  : null,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
