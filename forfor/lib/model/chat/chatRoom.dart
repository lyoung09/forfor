import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  String? chatRoomId;
  List<String>? chattingwith;

  ChatRoom({
    this.chatRoomId,
    this.chattingwith,
  });

  ChatRoom.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    chatRoomId = documentSnapshot.id;
    chattingwith = documentSnapshot["chattingwith"];
  }
}
