import 'package:dartz/dartz.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/utility.dart';
import '../models/edit_profile_model.dart';
import '../params/edit_profile_params.dart';

abstract class EditProfileRepo {
  const EditProfileRepo();

  static Future<Either<ErrorEntity, EditProfileModel>> updateProfile(
    EditProfileParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.updateProfile,
        method: ServerMethods.PUT,
        body: params.returnedMap(),
      );
      return Right(EditProfileModel.fromJson(response.data));
    } catch (error) {
      final errorEntity = ApiErrorHandler().handleError(error);

      if (errorEntity.statusCode == 403) {
        Utility.logout();
      }

      return Left(errorEntity);
    }
  }
}
