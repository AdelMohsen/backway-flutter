import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/features/new_order/data/models/vehicle_type_model.dart';

class TransportTypeSectionWidget extends StatelessWidget {
  final String? selectedVehicleTypeId;
  final List<VehicleTypeModel> vehicleTypes;
  final ValueChanged<String?>? onVehicleTypeChanged;
  final VoidCallback? onUploadTap;
  final bool isFirstOptionSelected;
  final VoidCallback? onFirstOptionTap;
  final VoidCallback? onSecondOptionTap;
  final bool showExtraFileds;
  const TransportTypeSectionWidget({
    Key? key,
    this.selectedVehicleTypeId,
    this.vehicleTypes = const [],
    this.onVehicleTypeChanged,
    this.onUploadTap,
    this.showExtraFileds = false,
    this.isFirstOptionSelected = true,
    this.onFirstOptionTap,
    this.onSecondOptionTap,
  }) : super(key: key);

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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            AppStrings.transportType.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Black,
          ),
          const SizedBox(height: 16),
          // Vehicle Type Dropdown from API
          Padding(
            padding: EdgeInsetsDirectional.only(start: 8, end: 8),
            child: DefaultDropdownFormField(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              hintText: AppStrings.selectVehicleType.tr,
              value: selectedVehicleTypeId,
              borderRadious: 45,
              fillColor: const Color(0xFFF7F7F7),
              hintFontSize: 12,
              items: vehicleTypes
                  .map(
                    (v) => DropdownMenuItem<String>(
                      value: v.id.toString(),
                      child: Text(v.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (onVehicleTypeChanged != null) {
                  onVehicleTypeChanged!(value);
                  log(value.toString());
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          // Two clickable options (Transport / Installation)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // First Option - Transport
              GestureDetector(
                onTap: onFirstOptionTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryGreenHub,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                        color: AppColors.kWhite,
                      ),
                      child: Center(
                        child: isFirstOptionSelected
                            ? Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryGreenHub,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.transport.tr,
                      style: AppTextStyles.ibmPlexSansSize16w600Black.copyWith(
                        color: isFirstOptionSelected
                            ? AppColors.primaryGreenHub
                            : Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Second Option - Installation
              showExtraFileds
                  ? GestureDetector(
                      onTap: onSecondOptionTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: !isFirstOptionSelected
                                    ? AppColors.primaryGreenHub
                                    : Color.fromRGBO(241, 241, 241, 1),
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                              color: AppColors.kWhite,
                            ),
                            child: Center(
                              child: !isFirstOptionSelected
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryGreenHub,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.installation.tr,
                            style: AppTextStyles.ibmPlexSansSize16w600Black
                                .copyWith(
                                  color: !isFirstOptionSelected
                                      ? AppColors.primaryGreenHub
                                      : Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
