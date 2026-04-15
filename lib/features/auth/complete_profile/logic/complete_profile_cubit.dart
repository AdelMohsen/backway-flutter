import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Future<void> close() {
    usernameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    emailController.dispose();
    return super.close();
  }

  void validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    emit(FormValidationState(isValid));
  }

  Future<void> completeProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(CompleteProfileLoading());
      // Logic for profile completion will go here
      // For now, simulating success
      await Future.delayed(const Duration(seconds: 1));
      emit(const CompleteProfileSuccess("Profile updated successfully"));
    }
  }
}
