import 'package:flutter/cupertino.dart';

class Device {
  final int id;
  final String deviceName;
  final String lastHeartbeatTime;
  final bool onLine;
  
  Device({
    this.id,
    this.deviceName,
    this.lastHeartbeatTime,
    this.onLine,
  });

  factory Device.fromJson(dynamic item){
    return Device(
      id: item['id'], 
      deviceName: item['deviceName'], 
      lastHeartbeatTime: item['lastHeartbeatTime'], 
      onLine: item['onLine']
    );
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