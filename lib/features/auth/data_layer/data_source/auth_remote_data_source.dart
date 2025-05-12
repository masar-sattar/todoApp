import 'package:dio/dio.dart';
import 'package:todo_app/features/auth/data_layer/data_source/base_auth_remote_data_source.dart';
import 'package:todo_app/features/auth/data_layer/models/tokens_model.dart';

import '../../../../components/network/error_handler/api_error_model.dart';
import '../../domain_layer/entities/register_body.dart';

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<TokensModel> registerUser({
    required RegisterBody registerBody,
  }) async {
    // dio function for register
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://todo.iraqsapp.com",
      ),
    );

    (registerBody.toJson());

    try {
      Response response = await dio.post(
        '/auth/register',
        data: registerBody.toJson(),
      );

      if (response.statusCode == 201) {
        return TokensModel.fromJson(response.data);
      } else {
        throw ApiErrorModel.fromJson(response.data);
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }
}
