import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  String? chatRoomId;
  List<dynamic>? chattingwith;
  Timestamp? lastTime;
  //bool? pin;
  ChatRoom({
    this.chatRoomId,
    this.chattingwith,
    this.lastTime,
    //this.pin,
  });

  ChatRoom.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    chatRoomId = documentSnapshot.id;
    chattingwith = documentSnapshot["chattingWith"];
    lastTime = documentSnapshot["lastMessageTime"];
    //pin = documentSnapshot["pin"];
  }
}
