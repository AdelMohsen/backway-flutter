import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_dropdown_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

import 'photo_upload_area.dart';
import 'shipment_request_label.dart';

class PackageDetailsCard extends StatelessWidget {
  const PackageDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 250, 251, 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.packageDetails.tr,
            style: Styles.urbanistSize14w600Orange.copyWith(
              color: const Color.fromRGBO(64, 64, 64, 1),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color.fromRGBO(243, 244, 246, 1), thickness: 1),
          const SizedBox(height: 16),

          /// Select Shipment City
          const _ShipmentCityField(),
          const SizedBox(height: 16),

          /// Item Type
          ShipmentRequestLabel(text: AppStrings.itemType.tr, isRequired: true),
          const SizedBox(height: 8),
          DefaultDropdownFormField(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(SvgImages.drop),
            ),
            fillColor: Colors.white,
            borderRadious: 100,
            borderColor: const Color.fromRGBO(245, 245, 245, 1),
            hintText: AppStrings.itemTypeHint.tr,
            items: [
              DropdownMenuItem(
                value: "Documents",
                child: Text(AppStrings.documents.tr),
              ),
              DropdownMenuItem(
                value: "Electronics",
                child: Text(AppStrings.electronics.tr),
              ),
              DropdownMenuItem(
                value: "Clothes",
                child: Text(AppStrings.clothes.tr),
              ),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),

          /// Approximate weight
          ShipmentRequestLabel(
            text: AppStrings.approximateWeight.tr,
            isRequired: true,
          ),
          const SizedBox(height: 8),
          DefaultFormField(
            textAlign: TextAlign.start,
            hintText: AppStrings.weightHint.tr,
            borderRadious: 45,
            borderColor: const Color.fromRGBO(245, 245, 245, 1),
            fillColor: const Color.fromRGBO(255, 255, 255, 1),
            style: Styles.urbanistSize12w400White.copyWith(
              color: const Color.fromRGBO(156, 163, 175, 1),
            ),
          ),
          const SizedBox(height: 16),

          /// Size preset
          ShipmentRequestLabel(
            text: AppStrings.sizePreset.tr,
            isRequired: true,
          ),
          const SizedBox(height: 8),
          DefaultDropdownFormField(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(SvgImages.drop),
            ),
            fillColor: Colors.white,
            borderRadious: 100,
            borderColor: const Color.fromRGBO(245, 245, 245, 1),
            hintText: AppStrings.selectSizeHint.tr,
            items: [
              DropdownMenuItem(
                value: "Small",
                child: Text(AppStrings.small.tr),
              ),
              DropdownMenuItem(
                value: "Medium",
                child: Text(AppStrings.medium.tr),
              ),
              DropdownMenuItem(
                value: "Large",
                child: Text(AppStrings.large.tr),
              ),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),

          /// Package Description
          ShipmentRequestLabel(
            text: AppStrings.packageDescriptionOptional.tr,
            isRequired: false,
          ),
          const SizedBox(height: 8),
          DefaultFormField(
            hintStyle: Styles.urbanistSize12w400White.copyWith(
              color: const Color.fromRGBO(156, 163, 175, 1),
            ),
            textAlign: TextAlign.start,
            hintText: AppStrings.packageDescriptionHint.tr,
            maxLines: 4,
            borderRadious: 20,
            borderColor: const Color.fromRGBO(245, 245, 245, 1),
            fillColor: const Color.fromRGBO(255, 255, 255, 1),
            style: Styles.urbanistSize12w400White.copyWith(
              color: const Color.fromRGBO(156, 163, 175, 1),
            ),
          ),
          const SizedBox(height: 16),

          /// Shipment photos
          ShipmentRequestLabel(
            text: AppStrings.shipmentImages.tr,
            isRequired: true,
          ),
          const SizedBox(height: 8),
          const PhotoUploadArea(),
        ],
      ),
    );
  }
}

class _ShipmentCityField extends StatelessWidget {
  const _ShipmentCityField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShipmentRequestLabel(
          text: AppStrings.selectShipmentCity.tr,
          isRequired: true,
          fontSize: 14,
        ),
        const SizedBox(height: 12),
        DefaultDropdownFormField(
          hintText: AppStrings.chooseCityForShipmentHint.tr,
          items: [
            DropdownMenuItem(
              value: "Riyadh",
              child: Text(AppStrings.riyadh.tr),
            ),
            DropdownMenuItem(
              value: "Jeddah",
              child: Text(AppStrings.jeddah.tr),
            ),
            DropdownMenuItem(
              value: "Dammam",
              child: Text(AppStrings.dammam.tr),
            ),
          ],
          onChanged: (value) {},
          suffixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(SvgImages.drop),
          ),
          fillColor: Colors.white,
          borderRadious: 100,
          borderColor: const Color.fromRGBO(245, 245, 245, 1),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 11,
          ),
        ),
      ],
    );
  }
}
