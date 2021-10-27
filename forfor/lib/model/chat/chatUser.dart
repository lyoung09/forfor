import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class ChatUsers {
  String? idUser;

  String? name;
  String? messageText;
  String? urlAvatar;
  Timestamp? lastMessageTime;

  ChatUsers({
    this.name,
    this.idUser,
    this.messageText,
    this.urlAvatar,
    this.lastMessageTime,
  });

  ChatUsers.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    print(documentSnapshot.id);
    print(documentSnapshot["datetime"]);
    idUser = documentSnapshot.id;
    name = documentSnapshot["name"];
    messageText = documentSnapshot["messageText"];
    urlAvatar = documentSnapshot["urlAvatar"];
    lastMessageTime = documentSnapshot["lastMessageTime"];
  }
}
