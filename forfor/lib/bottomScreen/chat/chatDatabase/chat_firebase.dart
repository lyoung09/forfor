import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatFirebase {
  final _firebase = FirebaseFirestore.instance;
  File? _file;
  var _image;
  String urlProfileImageApi = "";
  CollectionReference cs = FirebaseFirestore.instance.collection('message');
  final String chatId;
  final String messageFrom;
  final String messageTo;

  ChatFirebase({
    required this.chatId,
    required this.messageFrom,
    required this.messageTo,
  });

  DateTime now() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate();
    return myDateTime;
  }

  imgFromGallery(token, username) async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    _file = imageFile != null ? File(imageFile.path) : null;

    try {
      Reference ref =
          FirebaseStorage.instance.ref().child("chatting/${chatId}/${now()}");

      await ref.putFile(_file!);

      urlProfileImageApi = await ref.getDownloadURL().then((value) {
        return value;
      });
      await cs.doc(chatId).collection('chatting').add({
        "messageFrom": messageFrom,
        "messageTo": messageTo,
        "messageUrl": urlProfileImageApi,
        "messageTime": now(),
        "messageText": null,
        "replyName": "",
        "isRead": false
      }).then((value) {
        cs.doc(chatId).update({"lastMessageTime": now()});
      });
      sendChattingFCM(
          username, "[image]", messageTo, messageFrom, chatId, token);
    } catch (e) {
      print(e);
    }
  }

  sendMessage(message, token, userName) async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        await cs.doc(chatId).collection('chatting').add({
          "reply": "",
          "replyId": "",
          "replyImage": "",
          "messageFrom": messageFrom,
          "messageTo": messageTo,
          "messageText": message.text,
          "messageTime": now(),
          "isRead": false
        }).then((value) {
          cs.doc(chatId).update({"lastMessageTime": now()});
        });
        sendChattingFCM(
            userName, message.text, messageTo, messageFrom, chatId, token);
        message.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  final HttpsCallable sendChattingFCMCall =
      FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('sendChattingFCM'); // 호출할 Cloud Functions 의 함수명

  void sendChattingFCM(title, body, myId, userId, chatId, token) async {
    try {
      print(body);
      final HttpsCallableResult result =
          await sendChattingFCMCall.call(<dynamic, dynamic>{
        "token": token,
        "title": '${title}님이 메세지를 보냈습니다.',
        "body": body,
        "myId": myId,
        "otherId": userId,
        "chattingId": chatId
      });
    } catch (e) {
      print('${e} error');
    }
  }

  String replymessageName = "";
  String replymessage = "";

  sendReply(message, replymessage, replymessageName, replyImage, token,
      username) async {
    print(replymessageName);
    print(replymessage);
    if (message.text.trim().isEmpty) {
    } else {
      try {
        await cs.doc(chatId).collection('chatting').add({
          "reply": replymessage == null ? null : replymessage,
          "replyId": replymessageName == null ? null : replymessageName,
          "replyImage": replyImage == null ? null : replyImage,
          "messageFrom": messageFrom,
          "messageTo": messageTo,
          "messageText": message.text,
          "messageTime": now(),
          "isRead": false
        }).then((value) {
          cs.doc(chatId).update({"lastMessageTime": now()});
        });
        sendChattingFCM(
            username, message.text, messageTo, messageFrom, chatId, token);
        message.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  isRead() async {
    cs
        .doc(chatId)
        .collection('chatting')
        .where('messageFrom', isEqualTo: messageTo)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) async {
        await cs
            .doc(chatId)
            .collection('chatting')
            .doc(element.id)
            .update({"isRead": true});
      });
    });
  }
}
