import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/misc/restart_widget.dart';
import 'package:greenhub/features/language/ui/widgets/language_option_item.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Get current language from mainAppBloc
  String get selectedLanguage => mainAppBloc.isArabic ? 'ar' : 'en';

  Future<void> _changeLanguage(String langCode) async {
    await mainAppBloc.setLanguage(langCode);
    setState(() {});
    // Restart app to apply language change
    if (mounted) {
      RestartWidget.restartApp(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: CustomScaffoldWidget(
        needAppbar: false,
        backgroundColor: AppColors.kWhite,
        child: Column(
          children: [
            GradientHeaderLayout(
              showAction: true,
              title: AppStrings.language.tr,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 16,
                    top: 30,
                    end: 16,
                  ),
                  child: Column(
                    children: [
                      // Arabic Language Option
                      LanguageOptionItem(
                        title: AppStrings.arabic.tr,
                        isSelected: selectedLanguage == 'ar',
                        onTap: () {
                          _changeLanguage('ar');
                        },
                      ),
                      const SizedBox(height: 12),
                      // English Language Option
                      LanguageOptionItem(
                        title: AppStrings.english.tr,
                        isSelected: selectedLanguage == 'en',
                        onTap: () {
                          _changeLanguage('en');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
