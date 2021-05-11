import 'package:esp_remote_control_app/view/rootPages/Home.dart';
import 'package:esp_remote_control_app/view/subPages/SignIn.dart';
import 'package:esp_remote_control_app/view/subPages/SignUp.dart';
import 'package:fluro/fluro.dart'; // 引入路由包依赖文件
import 'package:flutter/cupertino.dart';

// 创建每个路由的 Handler函数

var home = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(); //  PageOne 为 page_one 页面的 StatelessWidget
});

var signIn = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignIn();
});

var signUp = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignUp();
});
