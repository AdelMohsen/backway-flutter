import 'package:dartz/dartz.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/services/error_handler/error_handler.dart';
import '../../../../../core/services/network/network_helper.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../models/delete_account_model.dart';
import '../params/delete_account_params.dart';

abstract class DeleteAccountRepo {
  const DeleteAccountRepo();

  static Future<Either<ErrorEntity, DeleteAccountModel>> deleteAccount(
    DeleteAccountParams params,
  ) async {
    try {
      final response = await Network().request(
        Endpoints.deleteAccount,
        method: ServerMethods.DELETE,
        body: params.returnedMap(),
      );
      return Right(DeleteAccountModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
