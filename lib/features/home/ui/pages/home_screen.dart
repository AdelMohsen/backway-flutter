import 'package:flutter/material.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/assets/app_images.dart';
import '../../data/models/home_models.dart';
import '../widgets/home_header_sliver.dart';
import '../widgets/offers_section_widget.dart';
import '../widgets/services_section_widget.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<OfferModel> offers = [];
  List<ServiceModel> services = [];

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  void _loadHomeData() {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        offers = [
          OfferModel(
            id: 1,
            title: AppStrings.homeBannerTitle.tr,
            image: AppImages.homeBanner,
            discount: '40%',
          ),
        ];

        services = [
          ServiceModel(
            buttonColor: const Color.fromRGBO(4, 131, 114, 1),
            buttonTextColor: const Color.fromRGBO(255, 255, 255, 1),

            id: 2,
            title: AppStrings.serviceDeliveryTitle.tr,
            image: AppImages.serviceDelivery,
            description: AppStrings.serviceDeliveryDesc.tr,
          ),
          ServiceModel(
            buttonColor: const Color.fromRGBO(174, 207, 92, 1),
            buttonTextColor: Colors.black,
            id: 1,
            title: AppStrings.serviceInstallationTitle.tr,
            image: AppImages.serviceInstallation,
            description: AppStrings.serviceInstallationDesc.tr,
          ),
        ];

        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      needBottomGradient: false,
      child: CustomScrollView(
        slivers: [
          // Collapsing Header
          const HomeHeaderSliver(),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Column(
                    children: [
                      const OffersSectionWidget(),
                      const SizedBox(height: 16),
                      ServicesSectionWidget(services: services),
                      const SizedBox(height: 15),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
