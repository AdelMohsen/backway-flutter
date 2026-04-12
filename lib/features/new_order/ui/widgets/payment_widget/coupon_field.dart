import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class CouponField extends StatelessWidget {
  const CouponField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultFormField(
            textAlign: TextAlign.start,
            hintText: AppStrings.couponDiscount.tr,
            needValidation: false,
            fillColor: Color.fromRGBO(247, 247, 247, 1),
            borderColor: Color.fromRGBO(247, 247, 247, 1),
            enabledBorderColor: Color.fromRGBO(247, 247, 247, 1),
            foucsBorderColor: Color.fromRGBO(247, 247, 247, 1),
            borderRadious: 12,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.confirmation_number_outlined,
                color: Color.fromRGBO(160, 160, 167, 1),
                size: 20,
              ),
            ),
            hintStyle: AppTextStyles.ibmPlexSansSize12w400Grey.copyWith(
              color: Color.fromRGBO(160, 160, 167, 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 52,
          width: 67,
          decoration: BoxDecoration(
            color: Color.fromRGBO(174, 207, 92, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Text(
              AppStrings.activate.tr,
              style: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
