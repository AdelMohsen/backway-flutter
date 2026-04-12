import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/features/rate_negotiation/logic/cubit/rate_negotiation_cubit.dart';
import 'package:greenhub/features/rate_negotiation/logic/state/rate_negotiation_state.dart';
import 'package:greenhub/features/rate_negotiation/ui/widgets/rating_success_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';
import 'package:greenhub/features/rate_negotiation/ui/widgets/emoji_rating_widget.dart';
import 'package:greenhub/features/rate_negotiation/ui/widgets/negotiation_notes_section.dart';
import 'package:greenhub/features/rate_negotiation/ui/widgets/rate_negotiation_buttons.dart';

class RateNegotiationScreen extends StatefulWidget {
  final int orderId;

  const RateNegotiationScreen({Key? key, required this.orderId})
    : super(key: key);

  @override
  State<RateNegotiationScreen> createState() => _RateNegotiationScreenState();
}

class _RateNegotiationScreenState extends State<RateNegotiationScreen> {
  final TextEditingController _notesController = TextEditingController();
  int _selectedRatingIndex = -1;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RateNegotiationCubit(),
      child: BlocConsumer<RateNegotiationCubit, RateNegotiationState>(
        listener: (context, state) {
          if (state is RateNegotiationSuccess) {
            RatingSuccessBottomSheet.show(
              context,
              onOrderDetails: () {
                CustomNavigator.push(
                  Routes.ORDER_DETAILS,

                  extra: widget.orderId,
                );
              },
              onShipmentHistory: () {
                CustomNavigator.push(
                  Routes.NAV_LAYOUT,
                  extra: Routes.orders,
                  clean: true,
                );
              },
            );
          } else if (state is RateNegotiationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<RateNegotiationCubit>();

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
            ),
            child: CustomScaffoldWidget(
              resizeToAvoidBottomInset: true,
              needAppbar: false,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GradientHeaderLayout(
                            title: mainAppBloc.isArabic
                                ? "تقييم الناقل"
                                : "Rate the Carrier",
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 20,
                                start: 20,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 45),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      end: 20,
                                      start: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MainText(
                                            text: mainAppBloc.isArabic
                                                ? "يسرنا معرفة مدى رضالك عن الخدمة"
                                                : "We are pleased to know how satisfied you are with the service",
                                            style: AppTextStyles
                                                .ibmPlexSansSize16w600Black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 7),

                                  // Emoji Rating
                                  EmojiRatingWidget(
                                    selectedIndex: _selectedRatingIndex,
                                    onRatingSelected: (index) {
                                      setState(() {
                                        _selectedRatingIndex = index;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 32),

                                  // Notes Section
                                  NegotiationNotesSection(
                                    controller: _notesController,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RateNegotiationButtons(
                    isLoading: state is RateNegotiationLoading,
                    onConfirm: () {
                      if (_selectedRatingIndex != -1) {
                        cubit.submitRating(
                          widget.orderId,
                          _selectedRatingIndex,
                          _notesController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              mainAppBloc.isArabic
                                  ? "برجاء اختيار تقييم"
                                  : "Please select a rating",
                            ),
                          ),
                        );
                      }
                    },
                    onCancel: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
