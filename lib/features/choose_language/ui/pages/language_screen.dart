import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/misc/restart_widget.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/features/choose_language/ui/widgets/language_option_item.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLangCode;

  Future<void> _applyLanguage() async {
    if (_selectedLangCode == null) return;

    await mainAppBloc.setLanguage(_selectedLangCode!);
    if (mounted) {
      RestartWidget.restartApp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine active state based on selection
    final bool isActive = _selectedLangCode != null;
    final String currentLang = _selectedLangCode ?? '';
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
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      SvgPicture.asset(SvgImages.logo, height: 32),
                      const SizedBox(height: 70),
                      Center(
                        child: Text(
                          AppStrings.chooseLanguage.tr,
                          style: Styles.urbanistSize28w600White,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Center(
                          child: Text(
                            AppStrings.selectPreferredLanguage.tr,
                            textAlign: TextAlign.center,
                            style: Styles.urbanistSize16w600White.copyWith(
                              color: ColorsApp.kTextGrey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 44),
                      LanguageOptionItem(
                        title: AppStrings.english.tr,
                        flagIcon: ImagesApp.enFlag,
                        value: 'en',
                        groupValue: currentLang,
                        onChanged: (val) {
                          mainAppBloc.setLanguage(val!);
                          setState(() => _selectedLangCode = val);
                        },
                      ),
                      const SizedBox(height: 16),
                      LanguageOptionItem(
                        title: AppStrings.french.tr,
                        flagIcon: ImagesApp.frFlag,
                        value: 'fr',
                        groupValue: currentLang,
                        onChanged: (val) {
                          mainAppBloc.setLanguage(val!);
                          setState(() => _selectedLangCode = val);
                        },
                      ),
                      const SizedBox(height: 16),
                      LanguageOptionItem(
                        title: AppStrings.arabic.tr,
                        flagIcon: ImagesApp.arFlag,
                        value: 'ar',
                        groupValue: currentLang,
                        onChanged: (val) {
                          mainAppBloc.setLanguage(val!);
                          setState(() => _selectedLangCode = val);
                        },
                      ),
                      const Spacer(),
                      DefaultButton(
                        height: 48,
                        borderRadiusValue: 28,
                        backgroundColor: isActive
                            ? ColorsApp.KorangePrimary
                            : ColorsApp.buttonColor,
                        onPressed: () {
                          CustomNavigator.push(Routes.CHOOSE_ACCOUNT);
                        },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
