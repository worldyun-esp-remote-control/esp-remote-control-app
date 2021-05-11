import 'package:flutter/cupertino.dart';

class User {
  final int id;
  final String userName;
  final String password;

  User({
    this.id,
    this.userName,
    this.password
  });


  factory User.fromJson(dynamic item){
    return User(
      id: item['id'], 
      userName: item['userName'], 
    );
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if (id != null) {
      map['id'] = this.id;
    }
    if (userName != null) {
      map['userName'] = this.userName;
    }
    if (password != null) {
      map['password'] = this.password;
    }
    return map;
  }
}