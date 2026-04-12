import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../user/entity/user_entity.dart';
import '../../data/params/edit_profile_params.dart';
import '../../data/repository/edit_profile_repo.dart';
import '../state/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  //---------------------------------VARIABLES----------------------------------//
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Backend gender value: 'male' or 'female'
  String? selectedGender;

  //---------------------------------FUNCTIONS----------------------------------//
  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    return super.close();
  }

  /// Initialize controllers with existing user data from UserCubit
  void initFromUser(UserEntity user) {
    nameController.text = user.name;
    phoneController.text = user.phone;
    emailController.text = user.email;
    selectedGender = user.gender;
  }

  /// Convert localized display gender to backend value
  void setGender(String? displayValue) {
    if (displayValue == null) return;

    if (displayValue == AppStrings.male.tr) {
      selectedGender = 'male';
    } else if (displayValue == AppStrings.female.tr) {
      selectedGender = 'female';
    }
    emit(EditProfileInitial());
  }

  /// Get localized display value for current gender
  String? get displayGender {
    if (selectedGender == 'male') return AppStrings.male.tr;
    if (selectedGender == 'female') return AppStrings.female.tr;
    return null;
  }

  //----------------------------------VALIDATION----------------------------------//
  bool _isFormValid() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    }
    return false;
  }

  //----------------------------------REQUEST-----------------------------------//
  Future<void> updateProfile() async {
    if (!_isFormValid()) return;

    emit(const EditProfileLoading());

    final params = EditProfileParams(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      gender: selectedGender ?? '',
    );

    final response = await EditProfileRepo.updateProfile(params);
    response.fold(
      (failure) {
        return emit(EditProfileError(failure));
      },
      (success) {
        return emit(EditProfileSuccess(success));
      },
    );
  }
}
