import 'package:dio/dio.dart';
import 'package:esp_remote_control_app/utils/MyToast.dart';
import 'package:esp_remote_control_app/utils/UserInfo.dart';

import 'HttpException.dart';

// 自定义拦截器
class HttpInterceptor extends Interceptor {
  // 请求拦截
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    String token = UserInfo.getToken();
    options.headers['X-Token'] = token;
    super.onRequest(options, handler);
  }

  // 响应拦截
  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode == 200) {
      final bool success = response.data['success'];
      RequestOptions option = response.requestOptions;
      if (option.path.endsWith('/user/signIn') ||
          option.path.endsWith('/user/refresh')) {
        if (success) {
          final String token = response.data['data']['token'];
          UserInfo.setToken(token);
          UserInfo.setSignIn(true);
        }else{
          UserInfo.setSignIn(false);
        }
      }
      if (!success) {
        final String message = response.data['message'];
        MyToast.showToast(message);
      }
    }
    super.onResponse(response, handler);
  }

  // 异常拦截
  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // 覆盖异常为自定义的异常类
    HttpException httpException = HttpException.create(err);
    err.error = httpException;

    super.onError(err, handler);
  }
}
