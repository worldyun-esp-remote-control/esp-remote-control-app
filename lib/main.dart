import 'dart:io';

import 'package:esp_remote_control_app/utils/UserInfo.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esp_remote_control_app/router/Routers.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
} 

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //路由初始化
    final router = FluroRouter(); 
    Routers.configRouters(router);

    //加载用户信息
    UserInfo.loadUserInfo();

    return MaterialApp(
      title: "万能遥控",
      initialRoute: Routers.homePage,
      onGenerateRoute: router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      )
    );
  }
}
