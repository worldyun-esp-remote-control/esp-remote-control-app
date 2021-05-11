import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static String userName;
  static String token;
  static bool signIn;

  static String getUserName() {
    return userName;
  }

  static String getToken() {
    return token;
  }

  static bool getSignIn() {
    return signIn;
  }

  // ignore: missing_return
  static Future<Void> clean() async {
    userName = null;
    token = null;
    signIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    prefs.remove('token');
    prefs.setBool('signIn', false);
  }

  // ignore: missing_return
  static Future<Void> setUserName(String _userName) async {
    userName = _userName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _userName);
  }

  // ignore: missing_return
  static Future<Void> setToken(String _token) async {
    token = _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
  }

  // ignore: missing_return
  static Future<Void> setSignIn(bool _signIn) async {
    signIn = _signIn;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('signIn', _signIn);
  }

  static void loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName');
    token = prefs.getString('token');
    signIn = prefs.getBool('signIn');
  }
}
