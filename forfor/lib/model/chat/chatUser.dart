import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class ChatUsers {
  String? messageFrom;
  String? messageTo;
  String? messageText;
  Timestamp? messageTime;

  ChatUsers({
    this.messageTo,
    this.messageFrom,
    this.messageText,
    this.messageTime,
  });

  ChatUsers.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    messageFrom = documentSnapshot["messageFrom"];
    messageTo = documentSnapshot["messageTo"];
    messageText = documentSnapshot["messageText"];
    messageTime = documentSnapshot["messageTime"];
  }
}
