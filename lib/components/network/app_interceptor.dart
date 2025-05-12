import 'package:dio/dio.dart';


class AppInterceptor extends Interceptor {
  AppInterceptor();

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   super.onRequest(options, handler);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // unauthorized
    if (response.statusCode == 401) {
      /// call refresh Token api
      // DioHelper.getData(
      //   endPoint: "/auth/refresh-token",
      //   query: {
      //     "token": Caching.getData(key: AppConstance.refreshTokenKey),
      //   },
      // ).then((response) {
      //   if (response.statusCode == 200 && response.data['access_token'] != null) {
      //     // save new token from api in caching
      //     Caching.saveData(key: AppConstance.accessTokenKey,value: "Bearer ${response.data['access_token']}")
      //   }
      // },);

      /// update headers for the previous request
      // return handler.resolve(
      //   await DioHelper.dioInstance().fetch(
      //     response.requestOptions
      //       ..headers = {
      //         "Authorization":
      //             Caching.getData(key: AppConstance.accessTokenKey),
      //       },
      //   ),
      // );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("ERROR INTERCEPTOR : ${err.message}");
    super.onError(err, handler);
  }
}
