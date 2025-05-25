import 'package:dio/dio.dart';
import 'package:todo_app/components/network/dio_helper.dart';
import 'package:todo_app/features/auth/data_layer/data_source/auth_local_datasorce.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // unauthorized
    if (response.statusCode == 401) {
      /// call refresh Token api
      DioHelper.getData(
        endPoint: "/auth/refresh-token",
        query: {"token": await AuthLocalDatasorce().getRefreshToken()},
      ).then(
        (response) {
          if (response.statusCode == 200 &&
              response.data['access_token'] != null) {
            // save new token
            AuthLocalDatasorce().saveAccessToken(response.data['access_token']);

            DioHelper.token = response.data['access_token'];
          }
          ;
        },
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("ERROR INTERCEPTOR : ${err.message}");
    super.onError(err, handler);
  }
}
