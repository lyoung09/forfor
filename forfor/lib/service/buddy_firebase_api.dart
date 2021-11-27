import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/model/chat/chatRoom.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/model/user.dart';

class BuddyFirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> todoStream() {
    return _firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];

      query.docs.forEach((element) async {
        retVal.add(UserModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
