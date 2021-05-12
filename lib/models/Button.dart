import 'package:flutter/cupertino.dart';

class Button {
  final int id;
  final String buttonName;
  final int deviceId;

  Button({
    this.id,
    this.buttonName,
    this.deviceId
  });

  factory Button.fromJson(dynamic item){
    return Button(
      id: item['id'], 
      buttonName: item['buttonName'], 
      deviceId: item['deviceId']
    );
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if (id != null) {
      map['id'] = this.id;
    }
    if (buttonName != null) {
      map['buttonName'] = this.buttonName;
    }
    if (deviceId != null) {
      map['deviceId'] = this.deviceId;
    }
    return map;
  }
}

class ButtonList {
  final List<Button> list;

  ButtonList(this.list);

  factory ButtonList.fromJson(List<dynamic> list){
    return ButtonList(
      list.map((item) => Button.fromJson(item)).toList(),
    );
  }
}