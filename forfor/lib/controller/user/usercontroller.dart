import 'package:forfor/model/user.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import '../bind/authcontroller.dart';

class AllUserController extends GetxController {
  Rx<List<UserModel>> chatList = Rx<List<UserModel>>([]);
  List<UserModel> get todoss => chatList.value;
  @override
  void onInit() {
    chatList.bindStream(
        ChatFirebaseApi().userStream()); //stream coming from firebase
  }
}
