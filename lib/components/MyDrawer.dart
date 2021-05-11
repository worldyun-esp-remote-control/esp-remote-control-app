import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // SharedPreferences _prefs;
  String _username = "UnSignIn";
  bool _signIn = false;

  @override
  Future<void> initState() {
    // this._getInfo();
    super.initState();
  }

  // Future<void> _getInfo() async {
  //   this._prefs = await SharedPreferences.getInstance();
  //   if (this._prefs.containsKey("signIn")) {
  //     if (this._prefs.getBool("signIn")) {
  //       setState(() {
  //       this._signIn = true;
  //       this._username = this._prefs.getString("username");
  //     });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: UserAccountsDrawerHeader(
                accountName: Text(
                  this._username,
                  style: TextStyle(
                    color: Color.fromARGB(150, 0, 0, 0),
                    fontSize: 19,
                  ),
                ),
                // accountEmail: Text(
                //   "",
                //   style: TextStyle(
                //     color: Color.fromARGB(180, 0, 0, 0),
                //   ),
                // ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 150, 150, 175),
                  child: Text(
                    this._username[0],
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
                  image: AssetImage("images/drawerHeaderBackGroundImage.jpg"),
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
              // Navigator.of(context).pushNamed('/signIn');
              Navigator.pushNamed(context, '/signIn');
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
