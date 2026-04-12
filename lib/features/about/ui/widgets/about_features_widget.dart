import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/refresh_indicator.dart';
import 'package:greenhub/core/utils/widgets/shimmer/custom_shimmer.dart';
import 'package:greenhub/features/about/logic/cubit/about_services_cubit.dart';
import 'package:greenhub/features/about/logic/state/about_services_state.dart';

class AboutFeaturesWidget extends StatelessWidget {
  const AboutFeaturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutServicesCubit, AboutServicesState>(
      builder: (context, state) {
        if (state is AboutServicesLoading) {
          return _buildLoadingState();
        }

        if (state is AboutServicesSuccess || state is AboutServicesRefreshing) {
          final data = state is AboutServicesSuccess
              ? state.data.data
              : (state as AboutServicesRefreshing).data.data;
          return DefaultRefreshIndicatorWidget(
            onRefresh: () =>
                context.read<AboutServicesCubit>().getServices(isRefresh: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data?.title != null) ...[
                    Text(
                      data!.title!,
                      style: AppTextStyles.ibmPlexSansSize16w700Black.copyWith(
                        color: AppColors.primaryGreenHub,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  HtmlWidget(
                    data?.body ?? '',
                    textStyle: AppTextStyles.ibmPlexSansSize10w600White
                        .copyWith(
                          color: const Color.fromRGBO(146, 146, 146, 1),
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is AboutServicesError) {
          return Center(
            child: DefaultRefreshIndicatorWidget(
              onRefresh: () => context.read<AboutServicesCubit>().getServices(
                isRefresh: true,
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Text(state.error.message),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomShimmerContainer(height: 20, width: 150),
          SizedBox(height: 20),
          CustomShimmerContainer(height: 15),
          SizedBox(height: 10),
          CustomShimmerContainer(height: 15),
          SizedBox(height: 10),
          CustomShimmerContainer(height: 15),
          SizedBox(height: 10),
          CustomShimmerContainer(height: 15, width: 200),
        ],
      ),
    );
  }
}
