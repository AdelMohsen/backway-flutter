import 'package:dartz/dartz.dart';
import 'package:greenhub/core/shared/cache/cache_methods.dart';
import '../../../core/app_config/api_names.dart';
import '../../../core/services/error_handler/error_handler.dart';
import '../../../core/services/network/network_helper.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/utility.dart';
import '../entity/user_entity.dart';
import '../model/user_model.dart';

class UserRepo {
  const UserRepo();

  static Future<Either<ErrorEntity, UserEntity>> getUserData() async {
    try {
      print('🔍 User Repo: Fetching user data...');
      final response = await Network().request(
        Endpoints.getUserInfo,
        method: ServerMethods.GET,
      );
      final token = await CacheMethods.getToken();
      if (token == null) {
        print('⚠️ User Repo: No token found, user might not be logged in');
        return Left(
          ErrorEntity(statusCode: 401, message: 'Unauthorized', errors: []),
        );
      }

      print('✅ User Repo: User data fetched successfully');
      final UserEntity user = UserModel.fromJson(response.data, token: token);

      await CacheMethods.saveUser(user);
      await CacheMethods.saveToken(user.token);

      return Right(user);
    } catch (error) {
      print('❌ User Repo Error: $error');
      final errorEntity = ApiErrorHandler().handleError(error);

      if (errorEntity.statusCode == 403) {
        Utility.logout();
      }

      return Left(errorEntity);
    }
  }
}
