import 'package:esp_remote_control_app/models/Button.dart';
import 'package:esp_remote_control_app/services/ButtonService.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final Button button;

  const ButtonCard({Key key, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Colors.black38,
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          button.buttonName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
