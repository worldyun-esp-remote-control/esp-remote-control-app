import 'dart:async';

import 'package:esp_remote_control_app/models/Device.dart';
import 'package:esp_remote_control_app/services/DeviceService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:esp_remote_control_app/utils/MyToast.dart';
import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  Devices({Key key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  List<Widget> _listTiles = [Center(child: Text('没有设备，快去绑定一个吧'))];
  DeviceList _deviceList;
  Timer _timer;
  FocusNode _commentFocusDeviceName = FocusNode();
  FocusNode _commentFocusMqttId = FocusNode();
  String _deviceName;
  String _mqttId;

  @override
  void initState() {
    this._startTimer();
    this._getDevices();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "我的设备",
          style: TextStyle(color: Colors.black54),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color.fromARGB(10, 0, 0, 0),
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: this._add,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: 20,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        child: Center(
          child: ListView(
            children: this._listTiles,
          ),
        ),
      ),
    );
  }

  void _getListTiles() {
    List<Widget> listTiles = this
        ._deviceList
        .list
        .map((device) => Card(
              color: Colors.white70,
              child: ListTile(
                  title: Text(
                    device.deviceName,
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  subtitle: Text(
                    '上次在线时间：' + device.lastHeartbeatTime,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  enabled: true,
                  trailing: Icon(Icons.brightness_1,
                      color: device.onLine ? Colors.green[300] : Colors.black54
                  ),
                  onLongPress: () => this._longPress(device),
              ),
            ))
        .toList();
    setState(() {
      this._listTiles = listTiles;
    });
  }

  void _getDevices() async {
    DeviceList deviceList = await DeviceService.list();
    if (deviceList != null) {
      this._deviceList = deviceList;
      this._getListTiles();
    }
  }

  //每10s刷新一次设备
  void _startTimer() {
    const fiveSec = const Duration(seconds: 10);
    var callback = (timer) => this._getDevices();
    _timer = Timer.periodic(fiveSec, callback);
  }

  void _longPress(Device device) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          children: <Widget>[
            new SimpleDialogOption(
              child: Center(
                child: Text(
                  '删除',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ), 
              ),
              onPressed: () {
                this._delete(device);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  void _delete(Device device) async {
    bool success = await DeviceService.delete(device.toMap());
    if (success) {
      MyToast.showToast('删除成功');
      this._getDevices();
      eventBus.fire(RefreshRiarysEvent(true));
    }
  }

  void _add(){
    final top = 70.0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx2, state) {
          return Container(
            height:   400 + top,
            color: Colors.black12,
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 30,
                    bottom: 100,
                    right: 30,
                    top: top,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "设备名称",
                            ),
                            focusNode: this._commentFocusDeviceName,
                            onChanged: (value) {
                              this._deviceName = value;
                            },
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "设备编码",
                            ),
                            focusNode: this._commentFocusMqttId,
                            onChanged: (value) {
                              this._mqttId = value;
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                "添加",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 150, 150, 180)),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          TextStyle(
                                    color: Colors.white,
                                  ))),
                              onPressed: this._addDevice,
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
      },
    );
  }

  void _addDevice() async {
    Device device = new Device(deviceName: this._deviceName, mqttId: this._mqttId);
    bool success = await DeviceService.add(device.toMap());
    if (success) {
      MyToast.showToast('添加成功');
      eventBus.fire(RefreshRiarysEvent(true));
      Navigator.pop(context);
      this._getDevices();
    }
  }
}
