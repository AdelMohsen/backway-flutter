import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';

import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/choose_account/ui/widgets/account_type_option_item.dart';

class ChooseAccountScreen extends StatefulWidget {
  const ChooseAccountScreen({Key? key}) : super(key: key);

  @override
  State<ChooseAccountScreen> createState() => _ChooseAccountScreenState();
}

class _ChooseAccountScreenState extends State<ChooseAccountScreen> {
  String? _selectedAccountCode;

  void _onContinue() {
    if (_selectedAccountCode == null) return;
    
    // Once an account is selected, show them the onboarding sequence
    CustomNavigator.push(Routes.ON_BOARDING_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _selectedAccountCode != null;
    final String currentSelection = _selectedAccountCode ?? '';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorsApp.kPrimary,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        backgroundColor: ColorsApp.kPrimary,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(SvgImages.logo, height: 32),
                    GestureDetector(
                      onTap: () {
                        CustomNavigator.push(Routes.LANGUAGE);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        // Adjust padding to match circle size
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(253, 253, 253, 0.25),
                            width: 1,
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(SvgImages.lang),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Center(
                  child: Text(
                    AppStrings.chooseAccountType.tr,
                    textAlign: TextAlign.center,

                    style: Styles.urbanistSize28w600White,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    AppStrings.selectAccountTypeDescription.tr,
                    textAlign: TextAlign.center,
                    style: Styles.urbanistSize16w600White.copyWith(
                      color: ColorsApp.kTextGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                AccountTypeOptionItem(
                  title: AppStrings.shipper.tr,
                  subtitle: AppStrings.shipperDescription.tr,
                  imagePath: ImagesApp.shipper,
                  value: 'shipper',
                  groupValue: currentSelection,
                  onChanged: (val) =>
                      setState(() => _selectedAccountCode = val),
                ),
                const SizedBox(height: 16),
                AccountTypeOptionItem(
                  title: AppStrings.driver.tr,
                  subtitle: AppStrings.driverDescription.tr,
                  imagePath: ImagesApp.driver,
                  value: 'driver',
                  groupValue: currentSelection,
                  onChanged: (val) =>
                      setState(() => _selectedAccountCode = val),
                ),
                const Spacer(),
                DefaultButton(
                  height: 48,
                  borderRadiusValue: 28,
                  backgroundColor: isActive
                      ? ColorsApp.KorangePrimary
                      : ColorsApp.buttonColor,
                  onPressed: isActive ? _onContinue : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.continueText.tr,
                        style: Styles.urbanistSize14w700White,
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          SvgImages.back,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          height: 18,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
