import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/translation/all_translation.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

import '../../../../core/utils/widgets/sliders/carousal_widget.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../logic/cubit/offers_cubit.dart';
import '../../logic/state/offers_state.dart';

class OffersSectionWidget extends StatelessWidget {
  const OffersSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit()..getOffers(),
      child: const _OffersSectionContent(),
    );
  }
}

class _OffersSectionContent extends StatefulWidget {
  const _OffersSectionContent();

  @override
  State<_OffersSectionContent> createState() => _OffersSectionContentState();
}

class _OffersSectionContentState extends State<_OffersSectionContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppStrings.homeOffersTitle.tr,
                style: AppTextStyles.ibmPlexSansSize16w600Black,
              ),
              Image.asset(AppImages.offer, width: 17, height: 28),
            ],
          ),
          const SizedBox(height: 12),

          // Content
          BlocBuilder<OffersCubit, OffersState>(
            builder: (context, state) {
              if (state is OffersLoading) {
                return const CustomShimmerContainer(height: 144);
              } else if (state is OffersSuccess) {
                final offers = state.offersModel.data;
                if (offers.isEmpty) return const SizedBox();

                return SizedBox(
                  child: Stack(
                    children: [
                      SharedCarousalWidget(
                        autoPlay: true,
                        height: 144,
                        itemCount: offers.length,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index, realIndex) {
                          final imageUrl = offers[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      // Dots Indicator Overlay
                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(offers.length, (i) {
                            final bool isActive = _currentIndex == i;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: isActive ? 24 : 8,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.kWhite
                                    : AppColors.kWhite.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is OffersError) {
                return Container(
                  height: 144,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error.message,
                        style: AppTextStyles.ibmPlexSansSize16w600Black,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          color: AppColors.kPrimary,
                        ),
                        onPressed: () {
                          context.read<OffersCubit>().getOffers();
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
