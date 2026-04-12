import 'package:dartz/dartz.dart';
import '../../../../core/app_config/api_names.dart';
import '../../../../core/services/error_handler/error_handler.dart';
import '../../../../core/services/network/network_helper.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../models/wallet_transactions_model.dart';
import '../params/wallet_transactions_params.dart';

abstract class WalletTransactionsRepo {
  const WalletTransactionsRepo();

  /// Get wallet transactions with pagination
  static Future<Either<ErrorEntity, WalletTransactionsResponseModel>>
      getTransactions(WalletTransactionsParams params) async {
    try {
      final response = await Network().request(
        Endpoints.walletTransactions,
        method: ServerMethods.GET,
        queryParameters: params.returnedMap(),
      );
      return Right(WalletTransactionsResponseModel.fromJson(response.data));
    } catch (error) {
      return Left(ApiErrorHandler().handleError(error));
    }
  }
}
