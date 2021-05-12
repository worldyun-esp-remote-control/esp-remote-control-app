import 'dart:async';

import 'package:esp_remote_control_app/components/MyDrawer.dart';
import 'package:esp_remote_control_app/models/Button.dart';
import 'package:esp_remote_control_app/models/Device.dart';
import 'package:esp_remote_control_app/router/Routers.dart';
import 'package:esp_remote_control_app/services/ButtonService.dart';
import 'package:esp_remote_control_app/services/DeviceService.dart';
import 'package:esp_remote_control_app/services/UserService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:esp_remote_control_app/utils/MyToast.dart';
import 'package:esp_remote_control_app/view/rootPages/Buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<SignInEvent> _signInsEvent; //Event Bus
  StreamSubscription<RefreshRiarysEvent> _refreshRiarysEvent; //Event Bus
  String _buttonName;
  int _deviceId;
  String _deviceName;
  FocusNode _commentFocusButtonName = FocusNode();
  DeviceList _deviceList;
  List<DropdownMenuItem> _menuItem;

  @override
  void initState() {
    _signInsEvent = eventBus.on<SignInEvent>().listen((event) {
      //监听登录Event
      if (event.signIn) {
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, Routers.signInPage);
      }
    });

    _refreshRiarysEvent = eventBus.on<RefreshRiarysEvent>().listen((event) {
      //监听刷新Event
      if (event.refreshRiarys) {
        this._getDevices();
      }
    });
    this._getDevices();
    UserService.refresh();
    super.initState();
  }

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
      ),
      body: Buttons(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 150, 150, 175),
        child: Icon(Icons.add),
        onPressed: () {
          _add();
        },
      ),
    );
  }

  void _add() {
    final top = 25.0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx2, state) {
          return Container(
            height: MediaQuery.of(ctx2).viewInsets.bottom + 500 + top,
            color: Colors.black12,
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 30,
                    bottom: (MediaQuery.of(ctx2).viewInsets.bottom < 0)
                        ? 0
                        : MediaQuery.of(ctx2).viewInsets.bottom,
                    right: 30,
                    top: top,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "按钮名",
                            ),
                            focusNode: this._commentFocusButtonName,
                            onChanged: (value) {
                              this._buttonName = value;
                            },
                          ),
                          DropdownButton(
                            value: this._deviceName,
                            hint: Text('选择设备'),
                            isExpanded: true,
                            underline: Container(
                                height: 1,
                                color: Colors.green.withOpacity(0.7)),
                            items: _menuItem,
                            onChanged: (value) {
                              this._deviceId = value;
                              // this._deviceList.list.forEach((device) {
                              //   if (device.id == value) {
                              //     super.setState(() {
                              //       this._deviceName = device.deviceName;
                              //     });
                              //   }
                              // });
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
                              onPressed: this._addButton,
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

  List<DropdownMenuItem> _getDeviceDropdownMenuItem() {
    print(this._deviceList.list);
    List<DropdownMenuItem> menu = this
        ._deviceList
        .list
        .map((device) => new DropdownMenuItem(
              value: device.id,
              child: Text(device.deviceName),
            ))
        .toList();
    setState(() {
      this._menuItem = menu;
    });
  }

  void _addButton() async {
    Button button = new Button(buttonName: this._buttonName, deviceId: this._deviceId);
    bool success = await ButtonService.add(button.toMap());
    if(success){
      MyToast.showToast('添加成功');
      eventBus.fire(RefreshRiarysEvent(true));
    }
    Navigator.pop(context);
  }

  void _getDevices() async {
    DeviceList deviceList = await DeviceService.list();
    this._deviceList = deviceList;
    _getDeviceDropdownMenuItem();
  }
}
