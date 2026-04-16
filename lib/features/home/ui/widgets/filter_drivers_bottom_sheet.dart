import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/animations/entrance_animation.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_city_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';

class FilterDriversBottomSheet extends StatefulWidget {
  const FilterDriversBottomSheet({super.key});

  @override
  State<FilterDriversBottomSheet> createState() =>
      _FilterDriversBottomSheetState();
}

class _FilterDriversBottomSheetState extends State<FilterDriversBottomSheet> {
  int? selectedRating;
  String? selectedCity;

  final List<Map<String, String>> cities = [
    {'value': 'Riyadh', 'label': AppStrings.riyadh.tr},
    {'value': 'Jeddah', 'label': AppStrings.jeddah.tr},
    {'value': 'Dammam', 'label': AppStrings.dammam.tr},
    {'value': 'Mecca', 'label': AppStrings.mecca.tr},
    {'value': 'Medina', 'label': AppStrings.medina.tr},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Text(
              AppStrings.filterTitle.tr,
              style: Styles.urbanistSize20w600Orange.copyWith(
                color: ColorsApp.kPrimary,
              ),
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
          const SizedBox(height: 25),

          // Rating Section
          EntranceAnimation(
            delay: 100.ms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    AppStrings.ratingLabel.tr,
                    style: Styles.urbanistSize16w500White.copyWith(
                      color: Color.fromRGBO(38, 38, 38, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(5, (index) {
                      final rating = index + 1;
                      final bool isSelected = selectedRating == rating;
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedRating = rating),
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(
                              start: 22,
                              end: 22,
                              top: 6,
                              bottom: 6,
                            ),

                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromRGBO(243, 245, 250, 1)
                                  : const Color.fromRGBO(251, 251, 253, 1),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: isSelected
                                    ? ColorsApp.kPrimary
                                    : const Color.fromRGBO(243, 244, 246, 1),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(SvgImages.star),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: Styles.urbanistSize12w500Orange
                                      .copyWith(
                                        fontSize: 15,
                                        color: isSelected
                                            ? ColorsApp.kPrimary
                                            : const Color.fromRGBO(
                                                156,
                                                163,
                                                175,
                                                1,
                                              ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // City Section
          EntranceAnimation(
            delay: 200.ms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    AppStrings.exploreDriversByCity.tr,
                    style: Styles.urbanistSize14w600White.copyWith(
                      color: const Color.fromRGBO(64, 64, 64, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    AppStrings.selectCityDescription.tr,
                    style: Styles.urbanistSize14w400White.copyWith(
                      color: const Color.fromRGBO(156, 163, 175, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DefaultCityFormField(
                  centerTitle: true,
                  value: selectedCity,
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      value: city['value'],
                      child: Text(city['label']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedCity = value);
                  },
                  hintText: AppStrings.selectCity.tr,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Actions
          EntranceAnimation(
            delay: 300.ms,
            child: Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: ColorsApp.kPrimary,
                    borderRadiusValue: 30,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgImages.checks),
                        const SizedBox(width: 6),
                        Text(
                          AppStrings.applyFilters.tr,
                          style: Styles.urbanistSize14w700White.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DefaultButton(
                    onPressed: () {
                      setState(() {
                        selectedRating = null;
                        selectedCity = null;
                      });
                    },
                    backgroundColor: const Color.fromRGBO(251, 251, 253, 1),
                    borderRadiusValue: 30,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgImages.ckear),
                        const SizedBox(width: 6),
                        Text(
                          AppStrings.clearAll.tr,
                          style: Styles.urbanistSize14w700White.copyWith(
                            color: const Color.fromRGBO(107, 114, 128, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
