import 'package:dartz/dartz.dart';

import '../../../../components/network/error_handler/api_error_model.dart';
import '../entities/register_body.dart';
import '../entities/tokens.dart';

abstract class BaseAuthRepository {
  Future<Either<ApiErrorModel, Tokens>> registerUser({
    required RegisterBody registerBody,
  });
  Future<Either<ApiErrorModel, Tokens>> loginUser({
    required String phoneNumber,
    required String password,
  });
}
