import 'package:flutter/cupertino.dart';

class Device {
  final int id;
  final String deviceName;
  final String mqttId;
  final String lastHeartbeatTime;
  final bool onLine;
  
  Device({
    this.id,
    this.deviceName,
    this.lastHeartbeatTime,
    this.onLine,
    this.mqttId
  });

  factory Device.fromJson(dynamic item){
    return Device(
      id: item['id'], 
      deviceName: item['deviceName'], 
      lastHeartbeatTime: item['lastHeartbeatTime'] == null ? '此设备未曾上线' : item['lastHeartbeatTime'], 
      onLine: item['onLine']
    );
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if (id != null) {
      map['id'] = this.id;
    }
    if (deviceName != null) {
      map['deviceName'] = this.deviceName;
    }
    if (mqttId != null) {
      map['mqttId'] = this.mqttId;
    }
    return map;
  }
}

class DeviceList {
  final List<Device> list;

  DeviceList(this.list);

  factory DeviceList.fromJson(List<dynamic> list){
    return DeviceList(
      list.map((item) => Device.fromJson(item)).toList(),
    );
  }
}