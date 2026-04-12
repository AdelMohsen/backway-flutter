import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/features/offers/ui/widgets/offer_card.dart';
import 'package:greenhub/features/offers/logic/cubit/negotiations_cubit.dart';
import 'package:greenhub/features/offers/logic/state/negotiations_state.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/app_core.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NegotiationsCubit()..fetchNegotiations(),
      child: BlocListener<NegotiationsCubit, NegotiationsState>(
        listener: (context, state) {
          if (state is NegotiationRejectSuccess) {
            showSuccessToast(state.data.message ?? '');
          } else if (state is NegotiationRejectError) {
            showErrorToast(state.error.message);
          } else if (state is NegotiationAcceptSuccess) {
            showSuccessToast(state.data.message ?? '');
          } else if (state is NegotiationAcceptError) {
            showErrorToast(state.error.message);
          }
        },
        child: CustomScaffoldWidget(
          needAppbar: false,
          backgroundColor: AppColors.kWhite,
          child: GradientHeaderLayout(
            showAction: false,

            title: AppStrings.offersTitle.tr,
            child: BlocBuilder<NegotiationsCubit, NegotiationsState>(
              builder: (context, state) {
                if (state is NegotiationsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NegotiationsError) {
                  return Center(
                    child: Text(
                      state.error.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is NegotiationsSuccess) {
                  if (state.negotiations.isEmpty) {
                    return _buildEmptyWidget();
                  }

                  return RefreshIndicator(
                    onRefresh: () => context
                        .read<NegotiationsCubit>()
                        .fetchNegotiations(isRefresh: true),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: state.negotiations.length,
                      itemBuilder: (context, index) {
                        return OfferCard(
                          negotiation: state.negotiations[index],
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
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
            Image.asset(AppImages.offersEmpty),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ستصلك عروض الاسعار"
                  : "You will receive price quotes",
              style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ارسل طلبك إلى مقدَمي الخدمات، وستصلك عروض الأسعار قريبًا"
                  : "Send your request to the service providers,\n and you will receive price quotes soon.",
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
