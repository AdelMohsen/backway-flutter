import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenhub/core/assets/app_svg.dart';
import 'package:greenhub/core/navigation/custom_navigation.dart';
import 'package:greenhub/core/navigation/routes.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/widgets/bottom_sheets/delete_user_bottom_sheet.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/core/utils/widgets/misc/graident_heaader_layout.dart';
import 'package:greenhub/core/utils/widgets/shimmer/custom_shimmer.dart';
import 'package:greenhub/core/services/toast/toast_service.dart';
import 'package:greenhub/features/enable_notification/logic/cubit/enable_notification_cubit.dart';
import 'package:greenhub/features/enable_notification/logic/state/enable_notification_state.dart';
import 'package:greenhub/features/more/ui/widgets/more_menu_item.dart';
import 'package:greenhub/features/settings/ui/widgets/settings_item.dart';
import 'package:greenhub/features/user/logic/user_cubit.dart';
import 'package:greenhub/features/user/logic/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

import '../../../auth/delete_account/logic/cubit/delete_account_cubit.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  late bool isNotificationEnabled;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final userState = context.read<UserCubit>().state;
      if (userState is UserLoaded) {
        isNotificationEnabled =
            userState.user.notificationsEnabled ?? false;
      } else {
        isNotificationEnabled = false;
      }
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DeleteAccountCubit()),
        BlocProvider(create: (context) => EnableNotificationCubit()),
      ],
      child: Builder(
        builder: (context) {
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
                  /// 🔹 Menu List
                  GradientHeaderLayout(
                    showAction: true,
                    title: AppStrings.settingsTitle.tr,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                              start: 5,
                              top: 30,
                              end: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                // Language
                                SettingsItem(
                                  title: AppStrings.language.tr,
                                  description:
                                      AppStrings.settingsLanguageDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.language,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    CustomNavigator.push(Routes.LANGUAGE);
                                  },
                                ),
                                _divider(),

                                // Notifications
                                BlocConsumer<EnableNotificationCubit,
                                    EnableNotificationState>(
                                  listener: (context, state) {
                                    if (state is EnableNotificationSuccess) {
                                      final enabled = state
                                              .data.data?.notificationsEnabled ??
                                          isNotificationEnabled;
                                      setState(() {
                                        isNotificationEnabled = enabled;
                                      });
                                      // Refresh user profile to sync cache
                                      context
                                          .read<UserCubit>()
                                          .getUserProfile();
                                      final message = enabled
                                          ? AppStrings.notificationsEnabled.tr
                                          : AppStrings.notificationsDisabled.tr;
                                      ToastService.showSuccess(
                                          message, context);
                                    } else if (state
                                        is EnableNotificationError) {
                                      // Revert switch
                                      setState(() {
                                        isNotificationEnabled =
                                            !isNotificationEnabled;
                                      });
                                      ToastService.showError(
                                        state.error.message,
                                        context,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return SettingsItem(
                                      title: AppStrings.notifications.tr,
                                      description: AppStrings
                                          .settingsNotificationsDesc.tr,
                                      icon: SvgPicture.asset(
                                        AppSvg.notificationSettings,
                                        width: 24,
                                      ),
                                      trailing: state
                                              is EnableNotificationLoading
                                          ? const SizedBox(
                                              width: 40,
                                              height: 24,
                                              child:
                                                  CustomShimmerContainer(
                                                height: 24,
                                                width: 40,
                                              ),
                                            )
                                          : Transform.scale(
                                              scale: 0.6,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Switch.adaptive(
                                                activeColor: AppColors
                                                    .primaryGreenHub,
                                                activeTrackColor: AppColors
                                                    .primaryGreenHub,
                                                inactiveTrackColor:
                                                    const Color.fromRGBO(
                                                  199,
                                                  199,
                                                  199,
                                                  1,
                                                ),
                                                inactiveThumbColor:
                                                    AppColors.kPrimary100,
                                                thumbColor:
                                                    WidgetStateProperty
                                                        .all(
                                                  AppColors.kWhite,
                                                ),
                                                thumbIcon:
                                                    WidgetStateProperty
                                                        .all(
                                                  const Icon(null),
                                                ),
                                                trackOutlineColor:
                                                    WidgetStateProperty
                                                        .all(
                                                  const Color.fromRGBO(
                                                    199,
                                                    199,
                                                    199,
                                                    1,
                                                  ),
                                                ),
                                                value:
                                                    isNotificationEnabled,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isNotificationEnabled =
                                                        value;
                                                  });
                                                  context
                                                      .read<
                                                          EnableNotificationCubit>()
                                                      .toggleNotification(
                                                          value);
                                                },
                                                activeThumbColor: AppColors
                                                    .primaryGreenHub,
                                              ),
                                            ),
                                      onTap: () {},
                                    );
                                  },
                                ),
                                _divider(),

                                // Delete Account
                                SettingsItem(
                                  title: AppStrings.settingsDeleteAccount.tr,
                                  description:
                                      AppStrings.settingsDeleteAccountDesc.tr,
                                  icon: SvgPicture.asset(
                                    AppSvg.deleteAccount,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    final deleteAccountCubit = context
                                        .read<DeleteAccountCubit>();
                                    DeleteUserBottomSheet.show(
                                      context,
                                      title:
                                          AppStrings.settingsDeleteAccount.tr,
                                      subtitle: AppStrings
                                          .settingsDeleteAccountConfirm
                                          .tr,
                                      retryButtonText:
                                          AppStrings.settingsDeleteButton.tr,
                                      backToLoginText:
                                          AppStrings.settingsBackToHome.tr,
                                      onRetry: () {
                                        CustomNavigator.pop();
                                        deleteAccountCubit.deleteAccount(
                                          context,
                                        );
                                      },
                                      onBackToLogin: () {
                                        CustomNavigator.pop();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _divider() => const Divider(
    height: 1,
    indent: 20,
    endIndent: 20,
    color: Color.fromRGBO(243, 243, 243, 1),
  );
}

