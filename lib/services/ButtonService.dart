import 'package:esp_remote_control_app/http/Http.dart';
import 'package:esp_remote_control_app/models/Button.dart';

class ButtonService {
  static const String rootPath = '/button';
  static const String listPath = '$rootPath/list';
  static const String pressPath = '$rootPath/press';

  static Future list() async {
    final respons = await Http.get(
      listPath
    );
    return ButtonList.fromJson(respons['data']['list']);
  }

  static Future<bool> press(dynamic data) async {
    final respons = await Http.post(
      pressPath,
      data: data
    );
    bool success = respons['success'];
    return success;
  }
}