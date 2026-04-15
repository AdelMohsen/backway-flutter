import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import '../../logic/complete_profile_cubit.dart';
import '../widgets/complete_profile_body.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorsApp.KorangePrimary, ColorsApp.KorangeSecondary],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                /// Top Section
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 17,
                    end: 16,
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            SvgImages.logo,
                            width: 50,
                            height: 38,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.push(
                                Routes.LANGUAGE,
                                clean: true,
                              );
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
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
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.setUpProfile.tr,
                        style: Styles.urbanistSize28w700Orange.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.completeProfileSubtitle.tr,
                        style: Styles.urbanistSize14w400White.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocProvider(
                    create: (context) => CompleteProfileCubit(),
                    child: const CompleteProfileBody(),
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
