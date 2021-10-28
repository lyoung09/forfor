import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/user/usercontroller.dart';
import 'package:forfor/model/chat/chatRoom.dart';
import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import '../bind/authcontroller.dart';

class ChatController extends GetxController {
  Rx<List<ChatRoom>> chatList = Rx<List<ChatRoom>>([]);

  List<ChatRoom> get todos => chatList.value;
  final controller = Get.put(AuthController());

  @override
  void onInit() {
    chatList.bindStream(ChatFirebaseApi()
        .todoStream(controller.user!.uid)); //stream coming from firebase
  }
}
