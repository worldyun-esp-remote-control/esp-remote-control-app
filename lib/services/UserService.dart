import 'package:esp_remote_control_app/http/Http.dart';
import 'package:esp_remote_control_app/models/User.dart';

class UserService {
  static const String rootPath = '/user';
  static const String signInPath = '$rootPath/signIn';
  static const String signUpPath = '$rootPath/signUp';
  static const String infoPath = '$rootPath/info';
  static const String refreshPath = '$rootPath/refresh';

  static Future<bool> signIn(dynamic data) async {
    final respons = await Http.post(
      signInPath,
      data: data
    );
    bool success = respons['success'];
    return success;
  }

  static Future<bool> signUp(dynamic data) async {
    final respons = await Http.post(
      signUpPath,
      data: data
    );
    bool success = respons['success'];
    return success;
  }

  static Future<User> info() async {
    final respons = await Http.get(
      infoPath,
    );
    return User.fromJson(respons['data']['user']);
  }

  static Future<bool> refresh() async {
    final respons = await Http.get(
      refreshPath,
    );
    return respons['success'];
  }
}