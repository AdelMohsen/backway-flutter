import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/colors/styles.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    super.key,
    required this.child,
    this.appbar,
    this.floatingActionButton,
    this.backgroundColor = AppColors.kWhite,
    this.resizeToAvoidBottomInset,
    this.needAppbar = true,
    this.appbarTitle,
    this.appbarLeading,
    this.appbarHeight,
    this.centerAppbarTitle,
    this.systemOverlayStyle,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.needBottomGradient,
    this.needTopGradient,
    this.needGear,
    this.gearColor,
  });
  final Widget child;
  final PreferredSizeWidget? appbar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool needAppbar;
  final Widget? appbarTitle;
  final Widget? appbarLeading;
  final double? appbarHeight;
  final bool? centerAppbarTitle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool? needBottomGradient;
  final bool? needTopGradient;
  final bool? needGear;
  final Color? gearColor;

  @override
  Widget build(BuildContext context) {
    final Color? background = backgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.kWhite,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: needAppbar
          ? (appbar ??
                PreferredSize(
                  preferredSize: Size.fromHeight(appbarHeight ?? 0),
                  child: AppBar(
                    centerTitle: centerAppbarTitle,
                    backgroundColor: AppColors.kWhite,
                    elevation: 0,
                    systemOverlayStyle:
                        systemOverlayStyle ??
                        (background == AppColors.kWhite
                            ? const SystemUiOverlayStyle(
                                statusBarColor: AppColors.kWhite,
                                statusBarIconBrightness: Brightness.dark,
                                systemNavigationBarColor: AppColors.kWhite,
                                systemNavigationBarIconBrightness:
                                    Brightness.dark,
                              )
                            : SystemUiOverlayStyle.dark),
                    title: appbarTitle,
                    leading: appbarLeading,
                  ),
                ))
          : null,
      body: Stack(
        children: [
          if (needBottomGradient ?? false)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Color.fromRGBO(232, 230, 217, 0.2),
                    Color.fromRGBO(244, 158, 93, .2),
                  ],
                ),
              ),
            ),
          if (needTopGradient ?? false)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryGreenHub.withOpacity(0.1),
                    Colors.white,
                  ],
                ),
              ),
            ),

          child,
          //  const SafeArea(child: CheckFromInternetConnectionWidget()),
        ],
      ),
    );
  }
}
