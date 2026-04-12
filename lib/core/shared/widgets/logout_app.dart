import '../../assets/app_images.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/widgets/text/main_text.dart';
import 'package:flutter/material.dart';

import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../../theme/colors/styles.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(2),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(AppImages.log),
                MainText(
                  text: "تسجيل الدخول",
                  style: AppTextStyles.cairoW500Size16.copyWith(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        content: Text(
          textAlign: TextAlign.center,
          'هل انت متاكد من انك تريد تسجيل الخروج.',
          style: AppTextStyles.cairoW400Size12,
        ),

        actions: <Widget>[
          Column(
            children: [
              14.sbH,
              InkWell(
                onTap: () {
                  //       CustomNavigator.push(Routes.LOGIN_SCREEN, clean: true);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "نعم",
                      style: AppTextStyles.cairoW600Size16White,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.Kblue,
                  ),
                  width: 306,
                  height: 40,
                ),
              ),
              14.sbH,
              InkWell(
                onTap: () {
                  CustomNavigator.pop();
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "لا",
                      style: AppTextStyles.cairoW600Size16White.copyWith(
                        color: AppColors.kRed,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.kRed),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.kWhite,
                  ),
                  width: 306,
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
