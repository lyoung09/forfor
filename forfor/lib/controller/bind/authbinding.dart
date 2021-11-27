import 'package:forfor/controller/categoryController.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:get/get.dart';

import 'authcontroller.dart';
import 'usercontroller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());

    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
