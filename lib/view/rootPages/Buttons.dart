import 'dart:async';

import 'package:esp_remote_control_app/components/ButtonCard.dart';
import 'package:esp_remote_control_app/models/Button.dart';
import 'package:esp_remote_control_app/services/ButtonService.dart';
import 'package:esp_remote_control_app/utils/EvevBus.dart';
import 'package:esp_remote_control_app/utils/MyToast.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  Buttons({Key key}) : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  ButtonList _buttonList;
  int _count = 0;
  StreamSubscription<RefreshRiarysEvent> _refreshRiarysEvent; //Event Bus

  @override
  void initState() {
    _refreshRiarysEvent = eventBus.on<RefreshRiarysEvent>().listen((event) {
      //监听刷新Event
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
            mainAxisExtent: 70),
        itemBuilder: (BuildContext context, int index) {
          double panddingLift;
          double panddingRight;
          if (index % 3 == 0) {
            panddingLift = 16;
            panddingRight = 8;
          } else if (index % 3 == 1) {
            panddingLift = 8;
            panddingRight = 8;
          } else {
            panddingLift = 8;
            panddingRight = 16;
          }

          return Container(
            padding: EdgeInsets.only( top: 16, left: panddingLift, right: panddingRight),
            child: InkWell(
              child: Center(
                  child: ButtonCard(button: this._buttonList.list[index])
              ),
              onTap: () => this._press(this._buttonList.list[index]),
              onLongPress: () => this._longPress(this._buttonList.list[index]),
            ),
          );
        });
  }

  void _press(Button button) async {
    ButtonService.press(button.toMap());
  }

  void _longPress(Button button) async {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          children: <Widget>[
            new SimpleDialogOption(
              child: Center(
                child: Text(
                  '学习',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ), 
              ),
              onPressed: () {
                this._learn(button);
                Navigator.of(context).pop();
              },
            ),
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
                this._delete(button);
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

  void _learn(Button button) async {
    ButtonService.learn(button.toMap());
  }

   void _delete(Button button) async {
    bool success = await ButtonService.delete(button.toMap());
    if (success) {
      MyToast.showToast('删除成功');
      this._getButtons();
    }
  }
}
