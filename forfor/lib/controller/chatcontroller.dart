import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import 'bind/authcontroller.dart';

class ChatController extends GetxController {
  Rx<List<ChatUsers>> chatList = Rx<List<ChatUsers>>([]);

  List<ChatUsers> get todos => chatList.value;
  final controller = Get.put(AuthController());
  @override
  void onInit() {
    print(controller.user!.uid);
    chatList.bindStream(ChatFirebaseApi()
        .todoStream(controller.user!.uid)); //stream coming from firebase
  }
}
