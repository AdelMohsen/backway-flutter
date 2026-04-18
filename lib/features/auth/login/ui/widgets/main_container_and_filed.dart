import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/form_fields/default_phone_form_field.dart';
import 'package:greenhub/core/utils/widgets/toast/custom_toast.dart';

class MainContainerAndFiled extends StatefulWidget {
  const MainContainerAndFiled({super.key});

  @override
  State<MainContainerAndFiled> createState() => _MainContainerAndFiledState();
}

class _MainContainerAndFiledState extends State<MainContainerAndFiled> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_phoneController.text.length < 8) {
        CustomToast.showError(
          context,
          message: AppStrings.phoneFieldLabel.tr, // Reusing key for simplicity or use a dedicated validation string
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate a small delay for the "OTP Sent" experience
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        CustomNavigator.push(Routes.VERIFY_CODE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Phone Number Label
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  AppStrings.phoneFieldLabel.tr,
                  style: Styles.urbanistSize16w600White.copyWith(
                    fontSize: 14,
                    color: const Color.fromRGBO(64, 64, 64, 1),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              /// Phone Input Field
              DefaultPhoneFormField(
                controller: _phoneController,
                hintText: AppStrings.phoneFieldHint.tr,
                fillColor: const Color.fromRGBO(249, 250, 251, 1),
                borderColor: const Color(0xFFF5F6F8),
                hintStyle: Styles.urbanistSize14w400White.copyWith(
                  fontSize: 12,
                  color: const Color.fromRGBO(148, 163, 184, 1),
                ),
                style: Styles.urbanistSize14w400White.copyWith(
                  color: Colors.black87,
                ),
                borderRadious: 26,
                showCountryPicker: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    SvgImages.phone,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      const Color.fromRGBO(180, 180, 190, 1),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),

              const SizedBox(height: 38),

              /// Sign In Button
              DefaultButton(
                text: AppStrings.signIn.tr,
                isLoading: _isLoading,
                onPressed: _signIn,
                backgroundColor: ColorsApp.kPrimary,
                height: 48,
                borderRadiusValue: 28,
                textStyle: Styles.urbanistSize14w700White,
              ),

              const SizedBox(height: 32),

              /// New here? Create an account
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Placeholder for registration logic
                  },
                  child: RichText(
                    text: TextSpan(
                      text: AppStrings.newHere.tr,
                      style: Styles.urbanistSize14w400White.copyWith(
                        color: const Color.fromRGBO(133, 133, 133, 1),
                      ),
                      children: [
                        TextSpan(
                          text: " ${AppStrings.guestText.tr}",
                          style: Styles.urbanistSize14w400White.copyWith(
                            color: ColorsApp.kPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutBack);
  }
}
