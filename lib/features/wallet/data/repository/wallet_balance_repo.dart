import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/wallet_balance_model.dart';
import '../params/wallet_balance_params.dart';

abstract class WalletBalanceRepo {
  const WalletBalanceRepo();

  /// Get wallet balance
  static Future<Either<ErrorEntity, WalletBalanceResponseModel>>
      getBalance(WalletBalanceParams params) async {
    try {
      final response = await Network().request(
        Endpoints.walletBalance,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(WalletBalanceResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
