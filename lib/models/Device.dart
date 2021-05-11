import 'package:flutter/cupertino.dart';

class Device {
  final int id;
  final String deviceName;
  final DateTime lastHeartbeatTime;
  final bool onLine;
  
  Device({
    @required this.id,
    @required this.deviceName,
    @required this.lastHeartbeatTime,
    @required this.onLine,
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
      list.map((item) => Device.fromJson(item)),
    );
  }
}