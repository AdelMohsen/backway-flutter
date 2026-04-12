import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/features/add_address/logic/add_address_cubit.dart';
import 'package:greenhub/features/add_address/logic/add_address_state.dart';
import 'package:greenhub/features/edit_address/ui/widgets/custom_filed_edit_address.dart';
import '../../data/models/city_model.dart';
import '../../data/models/region_model.dart';

class AllFildsFormAddAddress extends StatelessWidget {
  const AllFildsFormAddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAddressCubit>();

    return Column(
      children: [
        const SizedBox(height: 20),

        /// Search Field
        // DefaultFormField(
        //   textAlign: TextAlign.right,
        //   controller: cubit.searchController,
        //   hintText: AppStrings.searchAboutAddress.tr,
        //   hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
        //     color: const Color.fromRGBO(152, 152, 152, 1),
        //   ),
        //   fillColor: const Color.fromRGBO(247, 247, 247, 1),
        //   borderColor: const Color.fromRGBO(247, 247, 247, 1),
        //   borderRadious: 45,
        //   prefixIcon: const Padding(
        //     padding: EdgeInsets.all(14.0),
        //     child: Icon(
        //       Icons.search,
        //       color: Color.fromRGBO(152, 152, 152, 1),
        //       size: 20,
        //     ),
        //   ),
        //   contentPadding: const EdgeInsets.symmetric(
        //     horizontal: 20,
        //     vertical: 18,
        //   ),
        //   needValidation: false,
        // ),
        const SizedBox(height: 16),
        Align(
          alignment: mainAppBloc.isArabic
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            AppStrings.addressType.tr,
            style: AppTextStyles.ibmPlexSansSize14w600Black,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<AddAddressCubit, AddAddressState>(
          builder: (context, state) {
            return Row(
              children: [
                _buildTypeChip(
                  context,
                  label: AppStrings.addressTypeHome.tr,
                  type: 'home',
                  isSelected: cubit.type == 'home',
                ),
                const SizedBox(width: 8),
                _buildTypeChip(
                  context,
                  label: AppStrings.addressTypeWork.tr,
                  type: 'work',
                  isSelected: cubit.type == 'work',
                ),
                const SizedBox(width: 8),
                _buildTypeChip(
                  context,
                  label: AppStrings.addressTypeOffice.tr,
                  type: 'office',
                  isSelected: cubit.type == 'office',
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        /// Address Title Field
        DefaultFormField(
          textAlign: TextAlign.start,
          controller: cubit.searchController,
          hintText: AppStrings.addressTitle.tr,
          hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
            color: const Color.fromRGBO(152, 152, 152, 1),
          ),
          fillColor: const Color.fromRGBO(247, 247, 247, 1),
          borderColor: const Color.fromRGBO(247, 247, 247, 1),
          borderRadious: 45,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          needValidation: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.thisFieldIsRequired.tr;
            } else if (value.length < 5) {
              return AppStrings.addressTitleMinLength.tr;
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        /// Governorate and City Row
        BlocBuilder<AddAddressCubit, AddAddressState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<RegionModel>(
                    decoration: InputDecoration(
                      hintText: AppStrings.selectRegion.tr,
                      hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey
                          .copyWith(
                            color: const Color.fromRGBO(152, 152, 152, 1),
                          ),
                      filled: true,
                      fillColor: const Color.fromRGBO(247, 247, 247, 1),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(44),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: cubit.selectedRegion,
                    isExpanded: true,
                    icon: state is RegionsLoading
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromRGBO(152, 152, 152, 1),
                          ),
                    items: cubit.regions.map((RegionModel region) {
                      return DropdownMenuItem<RegionModel>(
                        value: region,
                        child: Text(
                          region.name,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey,
                        ),
                      );
                    }).toList(),
                    onChanged: (RegionModel? newValue) {
                      if (newValue != null) {
                        cubit.selectRegion(newValue);
                      }
                    },
                    validator: (value) => value == null
                        ? AppStrings.thisFieldIsRequired.tr
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<CityModel>(
                    decoration: InputDecoration(
                      hintText: AppStrings.selectCity.tr,
                      hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey
                          .copyWith(
                            color: const Color.fromRGBO(152, 152, 152, 1),
                          ),

                      filled: true,
                      fillColor: const Color.fromRGBO(247, 247, 247, 1),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(44),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: cubit.selectedCity,
                    isExpanded: true,
                    icon: state is CitiesLoading
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromRGBO(152, 152, 152, 1),
                          ),
                    items: cubit.cities.map((CityModel city) {
                      return DropdownMenuItem<CityModel>(
                        value: city,
                        child: Text(
                          city.name,
                          style: AppTextStyles.ibmPlexSansSize12w600Grey,
                        ),
                      );
                    }).toList(),
                    onChanged: cubit.cities.isEmpty
                        ? null
                        : (CityModel? newValue) {
                            if (newValue != null) {
                              cubit.selectCity(newValue);
                            }
                          },
                    validator: (value) => value == null
                        ? AppStrings.thisFieldIsRequired.tr
                        : null,
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        /// District and Street Row
        Row(
          children: [
            CustomFiledEditAddress(
              controller: cubit.districtController,
              hintText: AppStrings.districtName.tr,
              needValidation: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.thisFieldIsRequired.tr;
                }
                return null;
              },
            ),
            const SizedBox(width: 12),
            CustomFiledEditAddress(
              controller: cubit.streetController,
              hintText: AppStrings.streetName.tr,
              needValidation: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.thisFieldIsRequired.tr;
                }
                return null;
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Building and Floor Row
        Row(
          children: [
            CustomFiledEditAddress(
              controller: cubit.buildingController,
              hintText: AppStrings.buildingNumber.tr,
              keyboardType: TextInputType.number,
              needValidation: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.thisFieldIsRequired.tr;
                }
                return null;
              },
            ),
            const SizedBox(width: 12),
            CustomFiledEditAddress(
              controller: cubit.floorController,
              hintText: AppStrings.floorNumber.tr,
              keyboardType: TextInputType.number,
              needValidation: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.thisFieldIsRequired.tr;
                }
                return null;
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Address Type Choice Chips
        const SizedBox(height: 20),

        /// Nearby Landmark Field
        DefaultFormField(
          textAlign: TextAlign.start,
          controller: cubit.notesController,
          hintText: AppStrings.notes.tr,
          hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
            color: const Color.fromRGBO(152, 152, 152, 1),
          ),
          fillColor: const Color.fromRGBO(247, 247, 247, 1),
          borderColor: const Color.fromRGBO(247, 247, 247, 1),
          borderRadious: 12,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          maxLines: 3,
          needValidation: false,
        ),

        const SizedBox(height: 16),

        /// Is Default Checkbox
        BlocBuilder<AddAddressCubit, AddAddressState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(247, 247, 247, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CheckboxListTile(
                value: cubit.isDefault,
                onChanged: (val) => cubit.toggleIsDefault(val),
                title: Text(
                  AppStrings.setAsDefaultAddress.tr,
                  style: AppTextStyles.ibmPlexSansSize14w600Black,
                ),
                activeColor: AppColors.primaryGreenHub,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTypeChip(
    BuildContext context, {
    required String label,
    required String type,
    required bool isSelected,
  }) {
    final cubit = context.read<AddAddressCubit>();
    return Expanded(
      child: GestureDetector(
        onTap: () => cubit.changeType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryGreenHub
                : const Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(44),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryGreenHub
                  : const Color.fromRGBO(247, 247, 247, 1),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                color: isSelected
                    ? Colors.white
                    : const Color.fromRGBO(152, 152, 152, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
