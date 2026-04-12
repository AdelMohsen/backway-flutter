import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/shimmer/custom_shimmer.dart';
import 'package:greenhub/features/about/logic/cubit/about_cubit.dart';
import 'package:greenhub/features/about/logic/state/about_state.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        if (state is AboutLoading) {
          return _buildLoadingState();
        } else if (state is AboutSuccess) {
          final data = state.data.data;
          return RefreshIndicator(
            onRefresh: () => context.read<AboutCubit>().getAbout(),
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
                    data?.body ?? "",
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
        } else if (state is AboutError) {
          return Center(
            child: RefreshIndicator(
              onRefresh: () => context.read<AboutCubit>().getAbout(),
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
