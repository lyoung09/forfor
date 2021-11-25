import 'package:forfor/controller/categoryController.dart';
import 'package:get/get.dart';

import 'authcontroller.dart';
import 'usercontroller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<UserController>(UserController());
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
  }
}
