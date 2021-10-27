import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/model/message.dart';

class ChatFirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatUsers>> todoStream(String uid) {
    return FirebaseFirestore.instance
        .collection("message")
        .doc(uid)
        .collection(uid)
        //.orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      print('hoit ${query.docs}');
      List<ChatUsers> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ChatUsers.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
