import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/model/chat/chatRoom.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/buddy_firebase_api.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import '../bind/authcontroller.dart';

class ChatController extends GetxController {
  Rx<List<UserModel>> chatList = Rx<List<UserModel>>([]);

  List<UserModel> get todos => chatList.value;
  final controller = Get.put(AuthController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    chatList.bindStream(
        BuddyFirebaseApi().todoStream()); //stream coming from firebase
  }
}
