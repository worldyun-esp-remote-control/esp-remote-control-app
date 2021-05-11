import 'package:esp_remote_control_app/http/Http.dart';
import 'package:esp_remote_control_app/models/Device.dart';

class DeviceService {
  
  static const String rootPath = '/device';

  static const String listPath = '$rootPath/list';

  static Future list() async {
    final respons = await Http.get(
      listPath
    );
    return DeviceList.fromJson(respons['devices']);
  }

} 