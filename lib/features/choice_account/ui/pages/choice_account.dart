import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/widgets/buttons/default_button.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';

import 'package:greenhub/core/utils/widgets/buttons/language_drop_down_button.dart';
import 'package:greenhub/core/translation/all_translation.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class ChoiceAccount extends StatefulWidget {
  const ChoiceAccount({Key? key}) : super(key: key);

  @override
  State<ChoiceAccount> createState() => _ChoiceAccountState();
}

class _ChoiceAccountState extends State<ChoiceAccount> {
  String? _currentLanguage;

  @override
  void initState() {
    super.initState();
    getPreferredLanguage();
  }

  Future<void> getPreferredLanguage() async {
    String lang = await allTranslations.getPreferredLanguage();
    print("lang $lang");
    if (lang.isEmpty || !(['ar', 'en'].contains(lang))) {
      lang = 'ar';
      await allTranslations.setNewLanguage(lang, false);
    }

    setState(() {
      _currentLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: mainAppBloc.langStream,
      initialData: _currentLanguage ?? 'ar',
      builder: (context, snapshot) {
        return Directionality(
          textDirection: mainAppBloc.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
            ),
            child: CustomScaffoldWidget(
              needAppbar: false,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(4, 131, 114, 0.54),
                          AppColors.kLightGreen,
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.center,
                      ),
                    ),
                    height: double.infinity,
                    child: Image.asset(
                      "assets/images/choose_account.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,

                    height: double.infinity,
                    child: Image.asset(AppImages.shadow, fit: BoxFit.cover),
                  ),

                  /// Top bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 25,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 10,
                            end: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Close Button

                              /// Language Dropdown
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withAlpha(80),
                                ),
                                height: 30,
                                child: LanguageDropdown(
                                  currentLanguage: _currentLanguage,
                                  englishFlag: AppImages.unFlag,
                                  arabicFlag: AppImages.saudiArabiaFlag,
                                  onChanged: (newLang) {
                                    allTranslations
                                        .setNewLanguage(newLang, true)
                                        .then((_) {
                                          setState(() {
                                            _currentLanguage = newLang;
                                          });
                                        });
                                  },
                                ),
                              ),
                              _buildCloseButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Overlay
                  Positioned(
                    left: 6,
                    right: 6,
                    bottom: 0,
                    child: Container(
                      height: 340,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(100),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                    ),
                  ),

                  /// Main Card
                  Container(
                    height: 329,
                    padding: const EdgeInsets.fromLTRB(20, 36, 20, 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          AppStrings.areYouNewUser.tr,
                          style: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        const SizedBox(height: 48),

                        DefaultButton(
                          height: 56,
                          width: 356,
                          borderRadius: BorderRadius.circular(44),
                          text: AppStrings.yesNew.tr,
                          textStyle: AppTextStyles.ibmPlexSansSize18w700Primary
                              .copyWith(color: Colors.white),
                          backgroundColor: AppColors.primaryGreenHub,
                          onPressed: () {
                            CustomNavigator.push(Routes.REGISTER);
                          },
                        ),
                        const SizedBox(height: 16),

                        DefaultButton(
                          elevation: 0.0,

                          height: 56,
                          width: 356,
                          borderAll: Color(0xffaed6d1),
                          onPressed: () {
                            CustomNavigator.push(Routes.REGISTER_OR_LOGIN);
                          },
                          borderRadius: BorderRadius.circular(44),
                          text: AppStrings.no.tr,
                          textStyle: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 18,
                            color: AppColors.primaryGreenHub,
                            fontWeight: FontWeight.w700,
                          ),

                          backgroundColor: Color(0xffebf5f4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildCloseButton() {
  return InkWell(
    onTap: () {},
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: 16,
      ),
    ),
  );
}
