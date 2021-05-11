import 'package:esp_remote_control_app/models/User.dart';
import 'package:esp_remote_control_app/services/UserService.dart';
import 'package:esp_remote_control_app/utils/MyToast.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _userName;
  String _password;
  FocusNode _commentFocusUserName = FocusNode();
  FocusNode _commentFocusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "登录",
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
                  focusNode: this._commentFocusUserName,
                  onChanged: (value) {
                    this._userName = value;
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "密码",
                  ),
                  focusNode: this._commentFocusPassword,
                  onChanged: (value) {
                    this._password = value;
                  },
                ),
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text(
                        "没有账号？去注册",
                        style: TextStyle(color: Colors.black54),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/signUp");
                      },
                    )),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "登录",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 150, 150, 180)),
                        textStyle:
                            MaterialStateProperty.all<TextStyle>(TextStyle(
                          color: Colors.white,
                        ))),
                    // colorBrightness: Colors.black54,
                    onPressed: this._signIn,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _signIn() async {
    this._commentFocusUserName.unfocus();
    this._commentFocusPassword.unfocus();
    User user = new User(
      userName: this._userName,
      password: this._password,
    );
    bool success = await UserService.signIn(user.toMap());
    if(success){
      MyToast.showToast("登录成功");
      new Future.delayed(const Duration(milliseconds: 500)).then((value){
        Navigator.pop(context);
      });
    }
  }
}
