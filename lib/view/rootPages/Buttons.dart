import 'dart:async';

import 'package:esp_remote_control_app/components/ButtonCard.dart';
import 'package:esp_remote_control_app/models/Button.dart';
import 'package:esp_remote_control_app/services/ButtonService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  Buttons({Key key}) : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  ButtonList _buttonList;
  int _count = 0;
  StreamSubscription<RefreshRiarysEvent> _refreshRiarysEvent;     //Event Bus

  @override
  void initState() {
    _refreshRiarysEvent = eventBus.on<RefreshRiarysEvent>().listen((event) {    //监听刷新Event
      if (event.refreshRiarys) {
        this._getButtons();
      }
    });
    this._getButtons();
    super.initState();
  }

  Future _getButtons() async {
    ButtonList buttonList = await ButtonService.list();
    setState(() {
      this._buttonList = buttonList;
      this._count = buttonList.list.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: this._count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0,
        // mainAxisSpacing: 8,
        mainAxisExtent: 70
        

      ), 
      itemBuilder: (BuildContext context, int index) {
        double panddingLift;
        double panddingRight;
        if(index % 3 == 0){
          panddingLift = 16;
          panddingRight = 8;
        }else if(index % 3 == 1){
          panddingLift = 8;
          panddingRight = 8;
        }else{
          panddingLift = 8;
          panddingRight = 16;
        }
        
        return Container(
          padding: EdgeInsets.only(top: 16, left: panddingLift, right: panddingRight),
          child: Center(
            child: ButtonCard( button: this._buttonList.list[index])
          ),
        );
      }
    );
  }
}
