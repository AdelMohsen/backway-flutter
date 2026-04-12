import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/features/new_order/data/models/package_type_model.dart';

class ShipmentDataSectionWidget extends StatefulWidget {
  final TextEditingController? weightController;
  final TextEditingController? phoneController;
  final String? selectedPackageTypeId;
  final List<PackageTypeModel> packageTypes;
  final ValueChanged<String?>? onPackageTypeChanged;
  final String? selectedPackageSize;
  final ValueChanged<String?>? onPackageSizeChanged;
  final bool showExtraFileds;
  final int vehiclesCount;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final FocusNode? phoneFocusNode;

  const ShipmentDataSectionWidget({
    Key? key,
    this.weightController,
    this.phoneController,
    this.showExtraFileds = false,
    this.selectedPackageTypeId,
    this.packageTypes = const [],
    this.onPackageTypeChanged,
    this.selectedPackageSize,
    this.onPackageSizeChanged,
    this.vehiclesCount = 1,
    this.onIncrement,
    this.onDecrement,
    this.phoneFocusNode,
  }) : super(key: key);

  @override
  State<ShipmentDataSectionWidget> createState() =>
      _ShipmentDataSectionWidgetState();
}

class _ShipmentDataSectionWidgetState extends State<ShipmentDataSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            AppStrings.shipmentData.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                AppStrings.weight.tr,
                style: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
              SizedBox(width: 4),
              Text(
                AppStrings.optional.tr,
                style: AppTextStyles.ibmPlexSansSize10w400.copyWith(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          DefaultFormField(
            textAlign: TextAlign.start,
            controller: widget.weightController ?? TextEditingController(),
            keyboardType: TextInputType.number,
            hintText: AppStrings.enterShipmentSize.tr,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Text(
                AppStrings.kg.tr,
                style: AppTextStyles.ibmPlexSansSize10w600White.copyWith(
                  color: AppColors.kTitleText,
                ),
              ),
            ),
            hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              color: const Color.fromRGBO(152, 152, 152, 1),
            ),
            fillColor: const Color.fromRGBO(247, 247, 247, 1),
            borderColor: const Color.fromRGBO(247, 247, 247, 1),
            borderRadious: 25,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            needValidation: false,
          ),
          SizedBox(height: 12),

          // Package Type Dropdown from API
          Text(
            AppStrings.selectPackageType.tr,
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
          ),
          SizedBox(height: 12),
          DefaultDropdownFormField(
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            hintText: AppStrings.selectPackageType.tr,
            value: widget.selectedPackageTypeId,
            borderRadious: 45,
            fillColor: const Color(0xFFF7F7F7),
            hintFontSize: 12,
            items: widget.packageTypes
                .map(
                  (p) => DropdownMenuItem<String>(
                    value: p.id.toString(),
                    child: Text(p.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (widget.onPackageTypeChanged != null) {
                widget.onPackageTypeChanged!(value);
              }
            },
          ),
          SizedBox(height: 12),

          // Package Size
          Text(
            AppStrings.packageSize.tr,
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSizeChip('small', AppStrings.small.tr),
              _buildSizeChip('medium', AppStrings.mediumSize.tr),
              _buildSizeChip('large', AppStrings.large.tr),
            ],
          ),
          SizedBox(height: 12),

          Text(
            AppStrings.recipientPhoneNumber.tr,
            style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
          ),
          SizedBox(height: 12),
          DefaultPhoneFormField(
            focusNode: widget.phoneFocusNode,
            controller: widget.phoneController,
            hintText: AppStrings.deliveryContactPhone.tr,
            needValidation: true,
            borderRadious: 25,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
          ),
          SizedBox(height: 16),
          // Vehicle Counter
          widget.showExtraFileds
              ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.vehiclesCount.tr,
                          style: AppTextStyles.ibmPlexSansSize12w500Title
                              .copyWith(color: Color.fromRGBO(0, 0, 0, 0.6)),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 247, 247, 1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left side: Counter text
                              Text(
                                '${widget.vehiclesCount}',
                                style: AppTextStyles.ibmPlexSansSize18w600White
                                    .copyWith(color: Colors.black),
                              ),
                              // Right side: Buttons grouped together
                              Row(
                                children: [
                                  // Decrement button
                                  GestureDetector(
                                    onTap: widget.onDecrement,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color.fromRGBO(
                                            217,
                                            217,
                                            217,
                                            1,
                                          ),
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Color.fromRGBO(152, 152, 152, 1),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  // Increment button
                                  GestureDetector(
                                    onTap: widget.onIncrement,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryGreenHub,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 350.ms, delay: 700.ms)
                    .slideY(begin: 0.5, end: 0.0, curve: Curves.fastOutSlowIn)
              : Container(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSizeChip(String value, String label) {
    final isSelected = widget.selectedPackageSize == value;
    return GestureDetector(
      onTap: () {
        if (widget.onPackageSizeChanged != null) {
          widget.onPackageSizeChanged!(value);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreenHub
              : const Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreenHub
                : const Color.fromRGBO(217, 217, 217, 1),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.ibmPlexSansSize12w500Title.copyWith(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
