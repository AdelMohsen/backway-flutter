import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';
import 'package:greenhub/features/new_order/ui/widgets/details_order_widget/single_container_widget.dart';

class NotesSectionWidget extends StatelessWidget {
  final TextEditingController? notesController;

  const NotesSectionWidget({Key? key, this.notesController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleContainerWidget(
      title: AppStrings.additionalNotes.tr,
      contentChild: DefaultFormField(
        textAlign: TextAlign.start,
        controller: notesController ?? TextEditingController(),
        hintText: AppStrings.writeNotesHere.tr,
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 100),
          child: SvgPicture.asset(AppSvg.note1, width: 24, height: 24),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 90),
            child: RotatedBox(
              quarterTurns: mainAppBloc.isArabic ? 0 : 1,
              child: SvgPicture.asset(AppSvg.note2, width: 20, height: 20),
            ),
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
    );
  }
}
