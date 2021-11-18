import 'package:permission_handler/permission_handler.dart';

class Handler {
  static Future<Map<Permission, PermissionStatus>> requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.notification].request();

    print(statuses);
    return statuses;
  }
}
