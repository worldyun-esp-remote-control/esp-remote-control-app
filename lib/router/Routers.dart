import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';                          // 引入路由包依赖文件
import 'package:esp_remote_control_app/router/RouterHandler.dart';

// 定义路由配置类
class Routers {
    static String homePage = '/';
    static String signInPage = '/signIn';
    static String signUpPage = '/signUp';
    //路由配置
    static void configRouters(FluroRouter  router){
        //找不到路由
        router.notFoundHandler = new Handler(
            handlerFunc: (BuildContext context,Map<String,List<String>> params){
                print('ERROR====>ROUTE WAS NOT FONUND!!!');
                return;
            }
        );
        //整体配置
        router.define(homePage, handler: home);  //  home 页面路由
        router.define(signInPage, handler: signIn);
        router.define(signUpPage, handler: signUp);
    }
}