import '../../../../core/shared/entity/error_entity.dart';
import '../../data/models/edit_profile_model.dart';

sealed class EditProfileState {
  const EditProfileState();
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess(this.data);
  final EditProfileModel data;
}

final class EditProfileError extends EditProfileState {
  const EditProfileError(this.error);
  final ErrorEntity error;
}
