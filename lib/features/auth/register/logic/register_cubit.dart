import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../data/params/register_params.dart';
import '../data/repo/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  //---------------------------------VARIABLES----------------------------------//
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isTermsAccepted = false;

  // Location data
  double? _latitude;
  double? _longitude;
  String? _address;

  String? get address => _address;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  //---------------------------------FUNCTIONS----------------------------------//
  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    return super.close();
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    emit(RegisterInitial());
  }

  bool isRegisterValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    }
    return false;
  }

  //----------------------------------LOCATION----------------------------------//
  void setLocation(double lat, double lng, String addr) {
    _latitude = lat;
    _longitude = lng;
    _address = addr;
    emit(LocationDetected(latitude: lat, longitude: lng, address: addr));
  }

  //----------------------------------REQUEST-----------------------------------//
  Future<void> registerUser() async {
    if (!isRegisterValidate()) return;

    if (!isTermsAccepted) {
      emit(RegisterError(_buildLocalError(AppStrings.pleaseAcceptTerms.tr)));
      return;
    }

    emit(const RegisterLoading());

    final params = RegisterParams(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      currentLat: _latitude?.toString() ?? '',
      currentLng: _longitude?.toString() ?? '',
      address: _address ?? '',
    );

    final response = await RegisterRepo.register(params);
    response.fold(
      (failure) {
        return emit(RegisterError(failure));
      },
      (success) {
        return emit(RegisterSuccess(success));
      },
    );
  }

  /// Build a local ErrorEntity for validation errors
  _buildLocalError(String message) {
    return ErrorEntity(statusCode: -1, message: message, errors: [message]);
  }
}
