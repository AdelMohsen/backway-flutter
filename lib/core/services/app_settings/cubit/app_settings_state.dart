import '../../../shared/entity/error_entity.dart';
import '../model/app_settings_model.dart';

sealed class AppSettingsState {
  const AppSettingsState();
}

final class AppSettingsInitial extends AppSettingsState {}

final class AppSettingsLoading extends AppSettingsState {
  const AppSettingsLoading();
}

final class AppSettingsSuccess extends AppSettingsState {
  final AppSettingsModel appSettingsModel;
  const AppSettingsSuccess(this.appSettingsModel);
}

final class AppSettingsError extends AppSettingsState {
  final ErrorEntity errorEntity;
  const AppSettingsError(this.errorEntity);
}
