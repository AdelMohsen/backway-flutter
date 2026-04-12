import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/app_settings_model.dart';
import '../repo/app_settings_repo.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(AppSettingsInitial());
  static AppSettingsCubit get(context) => BlocProvider.of(context);

  //---------------------------------VARIABLES----------------------------------//
  AppSettingsModel? appSettings;

  //---------------------------------GETTERS------------------------------------//
  StaticPages? get staticPages => appSettings?.data.staticPages;
  SocialMedia? get socialMedia => appSettings?.data.socialMedia;
  ContactInfo? get contact => appSettings?.data.contact;
  AppInfo? get appInfo => appSettings?.data.appInfo;

  String get terms => staticPages?.terms ?? '';
  String get privacy => staticPages?.privacy ?? '';
  String get aboutUs => staticPages?.aboutUs ?? '';

  //---------------------------------FUNCTIONS----------------------------------//

  //----------------------------------REQUEST-----------------------------------//
  Future<void> appSettingsStatesHandled() async {
    emit(const AppSettingsLoading());
    final response = await AppSettingsRepo.appSettings();
    response.fold(
      (failure) {
        return emit(AppSettingsError(failure));
      },
      (success) async {
        appSettings = success;
        return emit(AppSettingsSuccess(success));
      },
    );
  }

  /// Refresh settings from API
  Future<void> refreshSettings() async {
    await appSettingsStatesHandled();
  }
}
