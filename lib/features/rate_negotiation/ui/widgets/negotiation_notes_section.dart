import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/core/utils/widgets/text/main_text.dart';

import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class NegotiationNotesSection extends StatelessWidget {
  final TextEditingController controller;

  const NegotiationNotesSection({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20, start: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(
            text: AppStrings.yourNotes.tr,
            style: AppTextStyles.ibmPlexSansSize16w600Primary.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          DefaultFormField(
            textAlign: TextAlign.start,
            controller: controller,
            hintText: AppStrings.writeNotesHere.tr,
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 100),
              child: SvgPicture.asset(AppSvg.note1, width: 24, height: 24),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 90),
                child: SvgPicture.asset(AppSvg.note2, width: 20, height: 20),
              ),
            ),
            hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
              color: const Color.fromRGBO(152, 152, 152, 1),
            ),
            fillColor: const Color.fromRGBO(247, 247, 247, 1),
            borderColor: const Color.fromRGBO(247, 247, 247, 1),
            borderRadious: 12,
            maxLines: 5,
            needValidation: false,
          ),
        ],
      ),
    );
  }
}
