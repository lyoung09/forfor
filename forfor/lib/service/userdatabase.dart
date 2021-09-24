import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:get/get.dart';

class UserDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "email": user.email,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addDataUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).update({
        "gender": user.gender,
        "country": user.country,
        "nickname": user.nickname,
        "url": user.url
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addUserCategory(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).update({
        "gender": user.gender,
        "country": user.country,
        "nickname": user.nickname,
        "url": user.url
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
