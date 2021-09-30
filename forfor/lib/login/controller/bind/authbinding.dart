import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<UserController>(UserController());
  }
}
