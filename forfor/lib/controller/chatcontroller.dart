import 'package:firebase/firebase.dart';
import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import 'bind/authcontroller.dart';

class ChatController extends GetxController {
  Rx<List<ChatUsers>> chatList = Rx<List<ChatUsers>>([]);

  List<ChatUsers> get todos => chatList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user!.uid;
    chatList.bindStream(
        ChatFirebaseApi.todoStream(uid)); //stream coming from firebase
  }
}
