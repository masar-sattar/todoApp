// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:todo_app/features/auth/data_layer/data_source/base_auth_remote_data_source.dart';
// import 'package:todo_app/features/auth/data_layer/models/tokens_model.dart';

// import '../../../../components/network/error_handler/api_error_model.dart';
// import '../../domain_layer/entities/register_body.dart';

// class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
//   @override
//   Future<TokensModel> registerUser({
//     required RegisterBody registerBody,
//   }) async {
//     // dio function for register
//     final dio = Dio(
//       BaseOptions(
//         baseUrl: "https://todo.iraqsapp.com",
//       ),
//     );

//     try {
//       Response response = await dio.post(
//         '/auth/register',
//         data: registerBody.toJson(),
//       );

//       if (response.statusCode == 201) {
//         return TokensModel.fromJson(response.data);
//       } else {
//         throw ApiErrorModel.fromJson(response.data);
//       }
//     } catch (error) {
//       throw ApiErrorModel(message: error.toString());
//     }
//   }

//   @override
//   Future<TokensModel> loginUser({
//     required String phoneNumber,
//     required String passWord,
//   }) async {
//     // dio function for register
//     final dio = Dio(
//       BaseOptions(
//         baseUrl: "https://todo.iraqsapp.com",
//       ),
//     );

//     try {
//       Response response = await dio.post('/auth/login',
//           data: json.encode({"phone": phoneNumber, "password": passWord}));

//       if (response.statusCode == 201) {
//         return TokensModel.fromJson(response.data);
//       } else {
//         throw ApiErrorModel.fromJson(response.data);
//       }
//     } catch (error) {
//       throw ApiErrorModel(message: error.toString());
//     }
//   }
// }
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_app/features/auth/data_layer/data_source/base_auth_remote_data_source.dart';
import 'package:todo_app/features/auth/data_layer/models/tokens_model.dart';

import '../../../../core/network/error_handler/api_error_model.dart';
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

  @override
  Future<TokensModel> loginUser({
    required String phoneNumber,
    required String passWord,
  }) async {
    // dio function for register

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: "https://todo.iraqsapp.com",
          headers: {"Content-Type": "application/json"},
        ),
      );

      Response response = await dio.post(
        '/auth/login',
        data: json.encode({"phone": phoneNumber, "password": passWord}),
      );

      if (response.statusCode == 201) {
        return TokensModel.fromJson(response.data);
      } else {
        throw ApiErrorModel.fromJson(response.data);
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        final responseData = dioError.response?.data;

        String errorMessage = responseData['message'];

        // مثال على التعامل مع حالة 401 تحديدًا
        if (dioError.response?.statusCode == 401) {
          throw ApiErrorModel(message: errorMessage);
        } else {
          throw ApiErrorModel.fromJson(dioError.response?.data);
        }
      } else {
        // Dio error لكن بدون استجابة من السيرفر
        throw ApiErrorModel(message: dioError.message ?? 'حدث خطأ غير معروف');
      }
    } catch (error) {
      throw ApiErrorModel(message: error.toString());
    }
  }
}
