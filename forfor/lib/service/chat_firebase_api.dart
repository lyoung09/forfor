import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/utils/utils.dart';

class FirebaseApi {
  static Stream<List<ChatUsers>> getUsers(userId) => FirebaseFirestore.instance
      .collection('message')
      .doc(userId)
      .collection(userId)
      .orderBy('uid', descending: true)
      .snapshots()
      .transform(Utils.transformer(ChatUsers.fromJson) as StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<ChatUsers>>);

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: "!234",
      urlAvatar: "124",
      username: "jd",
      message: message,
      createdAt: DateTime.now(),
      fromMe: true,
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson) as StreamTransformer<
              QuerySnapshot<Map<String, dynamic>>, List<Message>>);

  static Future addRandomUsers(List<ChatUsers> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
