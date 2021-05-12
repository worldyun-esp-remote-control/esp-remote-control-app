import 'package:dio/dio.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
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
    //添加Token
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
      final int code = response.data['code'];

      //存储Token
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

      //存储用户名
      if(option.path.endsWith('/user/info') && success){
        final userName = response.data['data']['user']['userName'];
        UserInfo.setUserName(userName);
      }
      if (!success) {
        final String message = response.data['message'];
        MyToast.showToast(message);
      }

      //未登录的弹出登录界面
      if(code == 22004){
        eventBus.fire(SignInEvent(true));
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
