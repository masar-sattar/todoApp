import 'package:dartz/dartz.dart';
import 'package:todo_app/components/network/dio_helper.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';

import 'package:todo_app/features/auth/domain_layer/entities/tokens.dart';

import '../../../../components/network/error_handler/api_error_model.dart';
import '../../domain_layer/entities/register_body.dart';
import '../../domain_layer/repository/base_auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../data_source/base_auth_remote_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final AuthRemoteDataSource dataSource;
  final AuthLocalDatasorce authLocalDatasorce;

  AuthRepository({required this.dataSource, required this.authLocalDatasorce});

  @override
  Future<Either<ApiErrorModel, Tokens>> registerUser({
    required RegisterBody registerBody,
  }) async {
    // call register from data source (data layer)
    try {
      final result = await dataSource.registerUser(
        registerBody: registerBody,
      );

      return Right(result);
    } on ApiErrorModel catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<ApiErrorModel, Tokens>> loginUser(
      {required String phoneNumber, required String password}) async {
    try {
      final result = await dataSource.loginUser(
        phoneNumber: phoneNumber,
        passWord: password,
      );

      DioHelper.token = result.accesstoken;
      authLocalDatasorce.saveAccessToken(result.accesstoken);
      authLocalDatasorce.saveRefreshToken(result.refreshtoken);
      return Right(result);
    } on ApiErrorModel catch (error) {
      return Left(error);
    }
  }

  Future<bool> isAuth() async {
    final String? token = await authLocalDatasorce.getAccessToken();

    if (token == null) {
      return false;
    }

    DioHelper.token = token;
    return true;
  }
}
