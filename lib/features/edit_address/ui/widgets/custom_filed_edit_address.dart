import 'package:flutter/material.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';

import 'package:greenhub/core/utils/widgets/form_fields/default_form_field.dart';

class CustomFiledEditAddress extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool needValidation;
  final String? Function(String?)? validator;

  const CustomFiledEditAddress({
    Key? key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.needValidation = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultFormField(
        textAlign: mainAppBloc.isArabic ? TextAlign.right : TextAlign.left,
        controller: controller,
        hintText: hintText,
        hintStyle: AppTextStyles.ibmPlexSansSize12w600Grey.copyWith(
          color: const Color.fromRGBO(152, 152, 152, 1),
        ),
        fillColor: const Color.fromRGBO(247, 247, 247, 1),
        borderColor: const Color.fromRGBO(152, 152, 152, 0.2),
        borderRadious: 44,
        verticalEdge: 12,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        needValidation: needValidation,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}
