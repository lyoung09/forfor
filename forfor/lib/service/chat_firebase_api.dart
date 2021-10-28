import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/model/chat/chatMessage.dart';

import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/model/user.dart';

class ChatFirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatUsers>> todoStream(String uid, String chatId) {
    return _firestore
        .collection("message")
        // .doc(uid)

        .where('chattingWith', arrayContains: uid)
        //.orderBy("dateCreated", descending: true)

        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatUsers> retVal = [];
      query.docs.forEach((element) async {
        retVal.add(ChatUsers.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<UserModel>> userStream() {
    return _firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(UserModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return retVal;
    });
  }

  Stream<UserModel> eachUserStream(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((event) {
      return UserModel.fromDocumentSnapshot(documentSnapshot: event);
    });
  }
}
