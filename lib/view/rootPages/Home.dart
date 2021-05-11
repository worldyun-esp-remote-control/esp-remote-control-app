import 'package:esp_remote_control_app/components/MyDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Center(
        child: Text("未登录"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 150, 150, 175),
        child: Icon(Icons.create),
        onPressed: () {
          // Navigator.pushNamed(context, "/newDiary");
        },
      ),
    );
  }
}
