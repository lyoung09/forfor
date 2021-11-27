import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        "introduction": user.introduction,
        "deviceId": user.deviceId,
        "address": user.address,
        "lat": user.lat,
        "lng": user.lng,
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

  Future<bool> updateLocationUser(
      String uid, double lat, double lng, String address) async {
    try {
      await _firestore.collection("users").doc(uid).update({
        "lat": lat,
        "lng": lng,
        //"postion": GeoPoint(lat, lng),
        "address": address,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> currentUserChange(String uid, String deviceId) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .update({"deviceId": deviceId});

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

      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUserDs(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return _doc;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  convertUsre() async {
    try {
      final userDb = FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          );
      che();
      return userDb;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  che() async {
    print(UserModel().toJson());
  }

  changeUser() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          //.doc("Add")
          .snapshots()
          .listen((event) async {
        event.docs.forEach((element) {
          UserModel.fromJson(element.data());
        });
      });
      che();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
