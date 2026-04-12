import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/about/ui/widgets/about_app_widget.dart';
import 'package:greenhub/features/about/ui/widgets/about_features_widget.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/features/about/logic/cubit/about_cubit.dart';
import 'package:greenhub/features/about/logic/cubit/about_services_cubit.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AboutCubit()..getAbout()),
          BlocProvider(create: (context) => AboutServicesCubit()..getServices()),
        ],
        child: CustomScaffoldWidget(
          needAppbar: false,
          child: Column(
            children: [
              Expanded(
                child: GradientHeaderLayout(
                  backgroundColor: Colors.white,
                  showAction: true,
                  title: AppStrings.aboutApp.tr,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(),
                        child: TabBar(
                          padding: const EdgeInsetsDirectional.only(
                            start: 30,
                            end: 30,
                          ),
                          indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          dividerColor: const Color.fromRGBO(214, 214, 214, 1),
                          controller: _tabController,
                          labelColor: AppColors.primaryGreenHub,
                          unselectedLabelColor: const Color(0xFF9E9E9E),
                          indicatorColor: AppColors.primaryGreenHub,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: AppTextStyles.ibmPlexSansSize16w600Black,
                          tabs: [
                            Tab(text: AppStrings.aboutApp.tr),
                            Tab(text: AppStrings.ourServices.tr),
                          ],
                        ),
                      ),
                      // Tab Content Section
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            AboutAppWidget(),
                            AboutFeaturesWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
