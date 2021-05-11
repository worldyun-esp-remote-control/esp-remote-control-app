import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "注册",
            style: TextStyle(color: Colors.black54),
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "用户名",
                  ),
                  // focusNode: this._commentFocusUName,
                  // onChanged: (value) {
                  //   this._userInfo["username"] = value;
                  //   if (this._userInfo["password"].length >= 4 &&
                  //       this._userInfo["username"].length >= 6 &&
                  //       this._userInfo["username"].length <= 10) {
                  //     setState(() {
                  //       this._signFun = this._signIn;
                  //     });
                  //   } else {
                  //     setState(() {
                  //       this._signFun = null;
                  //     });
                  //   }
                  // },
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "密码",
                  ),
                  // focusNode: this._commentFocusPassWd,
                  // onChanged: (value) {
                  //   this._userInfo["password"] = value;
                  //   if (this._userInfo["password"].length >= 4 &&
                  //       this._userInfo["username"].length >= 6 &&
                  //       this._userInfo["username"].length <= 10) {
                  //     setState(() {
                  //       this._signFun = this._signIn;
                  //     });
                  //   } else {
                  //     setState(() {
                  //       this._signFun = null;
                  //     });
                  //   }
                  // },
                ),
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text(
                        "已有账号？去登录",
                        style: TextStyle(color: Colors.black54),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/signIn");
                      },
                    )),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      "注册",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // colorBrightness: Colors.black54,
                    color: Color.fromARGB(255, 150, 150, 180),
                    textColor: Colors.white,
                    // onPressed: this._signFun,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
