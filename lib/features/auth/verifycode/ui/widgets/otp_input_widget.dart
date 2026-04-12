import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/form_fields/default_pin_code_text_field_widget.dart';
import '../../logic/verify_code_cubit.dart';

class OtpInputWidget extends StatelessWidget {
  const OtpInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyCodeCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: DefaultPinCodeTextFieldWidget(
        length: 6,
        fieldHeight: 52,
        fieldWidth: 48,
        controller: cubit.otpController,
        borderRadious: 15,
        onCompleted: (v) {
          debugPrint("OTP Completed: $v");
        },
      ),
    );
  }
}
