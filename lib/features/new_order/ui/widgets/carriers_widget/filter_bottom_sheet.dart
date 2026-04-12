import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/widgets/custom_paint_slider.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(40, 2000);
  double _distance = 80;
  double _rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header with close button and title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.filterTitle.tr,
                  style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromRGBO(161, 161, 161, 1),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Divider(color: Color.fromRGBO(225, 233, 239, 1), thickness: 0.5),
            const SizedBox(height: 20),

            // Price Section
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppStrings.price.tr,
                style: AppTextStyles.ibmPlexSansSize14w500Grey.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceLabel('${_priceRange.start.toInt()}'),
                _buildPriceLabel('${_priceRange.end.toInt()}'),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryGreenHub,
                inactiveTrackColor: Colors.grey[200],
                thumbColor: const Color.fromRGBO(186, 220, 88, 1),
                overlayColor: AppColors.primaryGreenHub.withOpacity(0.2),
                trackHeight: 4,

                rangeThumbShape: const CustomRangeSliderThumbShape(),
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 0,
                max: 3000,
                onChanged: (values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Carrier Rating Section
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppStrings.carrierRating.tr,
                style: AppTextStyles.ibmPlexSansSize14w500Grey.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              child: DefaultDropdownFormField(
                value: _rating.toString(),
                items: [1.0, 2.0, 3.0, 4.0, 4.5, 5.0].map((rating) {
                  return DropdownMenuItem<String>(
                    value: rating.toString(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '$rating',
                          style: AppTextStyles.ibmPlexSansSize11w500Grey
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star_border,
                          color: Colors.orangeAccent,
                          size: 18,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _rating = double.parse(val);
                    });
                  }
                },
                fillColor: Colors.transparent,
                borderColor: const Color.fromRGBO(225, 233, 239, 1),
                borderRadious: 45,
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 28),

            // Distance Section
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppStrings.distance.tr,
                style: AppTextStyles.ibmPlexSansSize14w500Grey.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_distance.toInt()} Km',
                style: AppTextStyles.ibmPlexSansSize12w700Title.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryGreenHub,
                inactiveTrackColor: Colors.grey[200],
                thumbColor: const Color.fromRGBO(186, 220, 88, 1),
                overlayColor: AppColors.primaryGreenHub.withOpacity(0.2),
                trackHeight: 4,

                thumbShape: const CustomSliderThumbShape(),
              ),
              child: Slider(
                value: _distance,
                min: 0,
                max: 200,
                onChanged: (value) {
                  setState(() {
                    _distance = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Return filter values here
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenHub,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.apply.tr,
                          style: AppTextStyles.ibmPlexSansSize16w600Primary
                              .copyWith(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceRange = const RangeValues(40, 2000);
                        _distance = 80;
                        _rating = 4.5;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(186, 220, 88, 1),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.reset.tr,
                          style: AppTextStyles.ibmPlexSansSize16w600Primary
                              .copyWith(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),

                // Apply Button
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceLabel(String price) {
    return Row(
      children: [
        Text(
          price,
          style: GoogleFonts.almarai(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 2),
        SvgPicture.asset(AppSvg.riyal, width: 10, height: 10),
      ],
    );
  }
}

/// Custom slider thumb with lime green outer and teal inner circl
