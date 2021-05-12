import 'dart:async';

import 'package:esp_remote_control_app/models/User.dart';
import 'package:esp_remote_control_app/router/Routers.dart';
import 'package:esp_remote_control_app/services/UserService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:esp_remote_control_app/utils/UserInfo.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  
  String _userName = "UnSignIn";
  bool _signIn = false;
  StreamSubscription<RefreshRiarysEvent> _refreshRiarysEvent;     //Event Bus

  @override
  void initState() {
    _refreshRiarysEvent = eventBus.on<RefreshRiarysEvent>().listen((event) {    //监听刷新Event
      if (event.refreshRiarys) {
        this._getInfo();
      }
    });
    this._getInfo();
    super.initState();
  }
  

  void _getInfo() async {
    User user = await UserService.info();
    if (user != null) {
      setState(() {
        this._userName = user.userName;
        this._signIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  // ignore: missing_required_param
                  child: UserAccountsDrawerHeader(
                accountName: Text(
                  this._userName,
                  style: TextStyle(
                    color: Color.fromARGB(150, 0, 0, 0),
                    fontSize: 19,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 150, 150, 175),
                  child: Text(
                    this._userName[0],
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 3)
                        ]),
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/drawerHeaderBackGroundImage.jpg"),
                  fit: BoxFit.cover,
                )),
              ))
            ],
          ),
          InkWell(
            //登录跳转
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                child: Icon(
                  Icons.person,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
              title: Text(
                "${this._signIn ? '登出' : '登录/注册'}",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routers.signInPage);
            },
          ),
          Divider(),
          InkWell(
            //设置跳转
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                child: Icon(
                  Icons.settings,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
              title: Text(
                "设置",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            onTap: () {
              print("设置事件");
            },
          ),
        ],
      ),
    );
  }
}
