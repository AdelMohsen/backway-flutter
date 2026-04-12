import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_email_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:greenhub/features/auth/register/logic/register_cubit.dart';
import 'package:greenhub/features/auth/register/logic/register_state.dart';
import 'package:greenhub/features/auth/register/ui/widgets/location_map_picker_screen.dart';

class FormFiledRegister extends StatelessWidget {
  const FormFiledRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Column(
      children: [
        DefaultUsernameFormField(
          controller: cubit.nameController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              AppSvg.profileauth,
              colorFilter: const ColorFilter.mode(
                Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
          ),
          hintText: AppStrings.fullNameHint.tr,
          borderRadious: 45,
          validator: (value) {
            if (value == null || value.trim().length < 2) {
              return AppStrings.nameValidationError.tr;
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        DefaultPhoneFormField(
          controller: cubit.phoneController,
          hintText: AppStrings.phoneHint.tr,
          borderRadious: 45,
        ),
        SizedBox(height: 20),

        DefaultEmailFormField(
          controller: cubit.emailController,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              AppSvg.smsTracking,
              colorFilter: const ColorFilter.mode(
                Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
          ),
          borderRadious: 45,
        ),
        SizedBox(height: 20),

        // Location field - tappable to open map picker
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              current is LocationDetected || current is RegisterInitial,
          builder: (context, state) {
            final locationText = cubit.address;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                final result = await Navigator.push<MapPickerResult>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LocationMapPickerScreen(),
                  ),
                );
                if (result != null) {
                  cubit.setLocation(
                    result.latitude,
                    result.longitude,
                    result.address,
                  );
                }
              },
              child: IgnorePointer(
                child: DefaultUsernameFormField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppSvg.locationCo,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF9E9E9E),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: locationText ?? AppStrings.tapToDetectLocation.tr,
                  borderRadious: 45,
                  readonly: true,
                  controller: TextEditingController(text: locationText ?? ''),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
