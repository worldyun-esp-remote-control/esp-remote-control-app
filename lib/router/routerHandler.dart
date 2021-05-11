import 'package:esp_remote_control_app/view/rootPages/HomePage.dart';
import 'package:fluro/fluro.dart';          // 引入路由包依赖文件
import 'package:flutter/cupertino.dart';

// 创建每个路由的 Handler函数

var homePage =  new Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>>params ){
        return  HomePage();   //  PageOne 为 page_one 页面的 StatelessWidget
    }
);
