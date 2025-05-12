import 'package:dartz/dartz.dart';


import 'package:todo_app/features/auth/domain_layer/entities/tokens.dart';

import '../../../../components/network/error_handler/api_error_model.dart';
import '../../domain_layer/entities/register_body.dart';
import '../../domain_layer/repository/base_auth_repository.dart';
import '../data_source/base_auth_remote_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource dataSource;

  AuthRepository({
    required this.dataSource,
  });

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
}
