import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/user/usercontroller.dart';
import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import '../bind/authcontroller.dart';

class ChatController extends GetxController {
  Rx<List<ChatUsers>> chatList = Rx<List<ChatUsers>>([]);

  List<ChatUsers> get todos => chatList.value;
  final controller = Get.put(AuthController());
  final allUserController = Get.put(AllUserController());

  @override
  void onInit() {
    print('12345 ${allUserController.todoss.length}');
    // chatList.bindStream(ChatFirebaseApi()
    //     .todoStream(controller.user!.uid)); //stream coming from firebase
  }
}
