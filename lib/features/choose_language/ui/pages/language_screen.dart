import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/misc/restart_widget.dart';
import 'package:greenhub/features/choose_language/ui/widgets/language_option_item.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Get current language from mainAppBloc
  String get selectedLanguage => mainAppBloc.globalLang;

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
                SvgPicture.asset(SvgImages.logo, height: 32),
                const SizedBox(height: 52),
                Center(
                  child: Text(
                    AppStrings.chooseLanguage.tr,
                    style: Styles.urbanistSize28w600White,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    AppStrings.selectPreferredLanguage.tr,
                    textAlign: TextAlign.center,
                    style: Styles.urbanistSize16w600White.copyWith(
                      color: ColorsApp.kTextGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                LanguageOptionItem(
                  title: AppStrings.english.tr,
                  flagIcon: ImagesApp.enFlag,
                  value: 'en',
                  groupValue: selectedLanguage,
                  onChanged: (val) => _changeLanguage(val!),
                ),
                const SizedBox(height: 16),
                LanguageOptionItem(
                  title: AppStrings.french.tr,
                  flagIcon: ImagesApp.frFlag,
                  value: 'fr',
                  groupValue: selectedLanguage,
                  onChanged: (val) => _changeLanguage(val!),
                ),
                const SizedBox(height: 16),
                LanguageOptionItem(
                  title: AppStrings.arabic.tr,
                  flagIcon: ImagesApp.arFlag,
                  value: 'ar',
                  groupValue: selectedLanguage,
                  onChanged: (val) => _changeLanguage(val!),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle continue logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFAA90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      AppStrings.continueText.tr,
                      style: AppTextStyles.ibmPlexSansSize14w700Black.copyWith(
                        color: Colors.white,
                      ),
                    ),
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
