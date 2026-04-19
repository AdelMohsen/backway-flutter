import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../widgets/rate_driver_profile_header.dart';
import '../widgets/rate_driver_experience_rating.dart';
import '../widgets/rate_driver_feedback_chips.dart';
import '../widgets/rate_driver_comment_field.dart';
import '../widgets/rate_driver_bottom_buttons.dart';

class RateDriverScreen extends StatefulWidget {
  const RateDriverScreen({super.key});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  double _rating = 0;
  final List<String> _selectedTags = [];
  final TextEditingController _commentController = TextEditingController();

  final List<String> _tags = [
    AppStrings.punctual,
    AppStrings.safeDriving,
    AppStrings.professional,
    AppStrings.communication,
    AppStrings.vehicleCondition,
  ];

  void _onTagToggle(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Custom Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => CustomNavigator.pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(175, 175, 175, 0.12),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      SvgImages.kBackIcon,
                      colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(36, 35, 39, 1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    AppStrings.rateDriver.tr,
                    textAlign: TextAlign.center,
                    style: Styles.urbanistSize20w700Orange.copyWith(
                      color: const Color.fromRGBO(17, 17, 17, 1),
                    ),
                  ),
                ),
                const SizedBox(width: 44),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RateDriverProfileHeader(
                    name: AppStrings.dummyDriverName.tr,
                    vehicleType: AppStrings.cargoVan.tr,
                  ),
                  RateDriverExperienceRating(
                    rating: _rating,
                    onRatingUpdate: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                  ),
                  RateDriverFeedbackChips(
                    tags: _tags,
                    selectedTags: _selectedTags,
                    onTagToggle: _onTagToggle,
                  ),
                  RateDriverCommentField(controller: _commentController),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          RateDriverBottomButtons(
            onSubmit: () {
              // Handle submit logic
              CustomNavigator.pop();
            },
            onMaybeLater: () => CustomNavigator.pop(),
          ),
        ],
      ),
    );
  }
}
