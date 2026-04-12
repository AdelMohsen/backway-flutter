import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

class LanguageDropdown extends StatelessWidget {
  final String? currentLanguage;
  final Function(String) onChanged;

  final String arabicFlag;
  final String englishFlag;

  const LanguageDropdown({
    super.key,
    required this.currentLanguage,
    required this.onChanged,
    required this.arabicFlag,
    required this.englishFlag,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.grey.shade300,
      underline: SizedBox(),

      icon: SizedBox(),

      value: currentLanguage,
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Padding(
            padding: const EdgeInsets.only(
              left: 7,
              right: 7,
              top: 7,
              bottom: 7,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    AppStrings.english.tr,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),

                  child: Image.asset(AppImages.unFlag, height: 18),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'ar',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    AppStrings.arabic.tr,
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 9,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),

                  child: Image.asset(AppImages.saudiArabiaFlag, height: 25),
                ),
              ],
            ),
          ),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value); // value is guaranteed non-null
        }
      },
    );
  }
}
