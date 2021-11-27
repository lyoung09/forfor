import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/model/chat/chatRoom.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/model/user.dart';

class ChatFirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatRoom>> todoStream(String uid) {
    return _firestore
        .collection("message")
        .where('chattingWith', arrayContains: uid)
        //.orderBy('pin')
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatRoom> retVal = [];

      query.docs.forEach((element) async {
        retVal.add(ChatRoom.fromDocumentSnapshot(element));

        retVal.sort((a, b) => a.pin!.compareTo(b.pin!));
      });
      return retVal;
    });
  }

  // Stream<List<UserModel>> userStream() {
  //   return _firestore
  //       .collection("users")
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<UserModel> retVal = [];
  //     query.docs.forEach((element) {
  //       retVal.add(UserModel.fromDocumentSnapshot(documentSnapshot: element));
  //     });
  //     return retVal;
  //   });
  // }

  // Stream<UserModel> eachUserStream(uid) {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(uid)
  //       .snapshots()
  //       .map((event) {
  //     return UserModel.fromDocumentSnapshot(documentSnapshot: event);
  //   });
  // }
}
