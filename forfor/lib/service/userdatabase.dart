import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:get/get.dart';

class UserDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<bool> createNewUser(UserModel user) async {
  //   try {
  //     await _firestore.collection("users").doc(user.id).set({
  //       "email": user.email,
  //     });

  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> addDataUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "gender": user.gender,
        "country": user.country,
        "nickname": user.nickname,
        "url": user.url,
        "email": user.email,
        "access": user.access,
        "uid": user.id,
        "timeStamp": user.timeStamp,
        "introduction": null,
        "category": FieldValue.arrayUnion([
          user.category![0],
          user.category![1],
          user.category![2],
        ])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateDataUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).update({
        "nickname": user.nickname,
        "url": user.url,
        "introduction": user.introduction,
        "category": user.category,
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
