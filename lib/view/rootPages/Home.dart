import 'dart:async';

import 'package:esp_remote_control_app/components/MyDrawer.dart';
import 'package:esp_remote_control_app/router/Routers.dart';
import 'package:esp_remote_control_app/services/UserService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:esp_remote_control_app/view/rootPages/Buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  StreamSubscription<SignInEvent> _signInsEvent;     //Event Bus

  @override
  void initState() {
    _signInsEvent = eventBus.on<SignInEvent>().listen((event) {    //监听刷新Event
      if (event.signIn) {
        Navigator.pushNamed(context, Routers.signInPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "万能遥控",
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color.fromARGB(10, 0, 0, 0),
        brightness: Brightness.light,
        elevation: 0,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.calendar_today),
        //     onPressed: null,
        //   )
        // ],
      ),
      body: Buttons(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 150, 150, 175),
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.pushNamed(context, "/newDiary");
        },
      ),
    );
  }
}
