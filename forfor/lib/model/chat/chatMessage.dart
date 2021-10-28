import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String? chatUserId;
  String? message;
  String? time;
  String? chatUserAvatar;
  String? chatUserName;
  bool? isMessageRead;

  ChatMessage({
    required this.chatUserId,
    required this.message,
    required this.time,
    required this.chatUserAvatar,
    required this.chatUserName,
    required this.isMessageRead,
  });

  ChatMessage.fromDoc(DocumentSnapshot ds) {
    chatUserId = ds["chatUserId"];
    message = ds["message"];
    time = ds["time"];
    chatUserAvatar = ds["chatUserAvatar"];
    chatUserName = ds["chatUserName"];
    isMessageRead = ds["isMessageRead"];
  }
}
