import 'package:esp_remote_control_app/http/Http.dart';
import 'package:esp_remote_control_app/models/Device.dart';

class DeviceService {
  
  static const String rootPath = '/device';
  static const String listPath = '$rootPath/list';
  static const String addPath = '$rootPath/add';
  static const String deletePath = '$rootPath/delete';

  static Future list() async {
    final respons = await Http.get(
      listPath
    );
    return DeviceList.fromJson(respons['data']['devices']);
  }

  static Future add(dynamic data) async {
    final respons = await Http.post(
      addPath,
      data: data
    );
    bool success = respons['success'];
    return success;
  }

  static Future delete(dynamic params) async {
    final respons = await Http.delete(
      deletePath,
      params: params
    );
    bool success = respons['success'];
    return success;
  }

} 