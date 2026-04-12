import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      buildWhen: (previous, current) => current is TimerTick,
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        final seconds = state is TimerTick
            ? state.secondsRemaining
            : cubit.secondsRemaining;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cubit.formatTime(seconds),
              style: AppTextStyles.ibmPlexSansSize26w700White.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF333333),
              ),
            ),
          ],
        );
      },
    );
  }
}
