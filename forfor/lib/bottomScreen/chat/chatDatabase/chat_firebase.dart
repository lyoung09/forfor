import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  imgFromGallery() async {
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
    } catch (e) {
      print(e);
    }
  }

  sendMessage(message) async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        await cs.doc(chatId).collection('chatting').add({
          "reply": "",
          "replyId": "",
          "messageFrom": messageFrom,
          "messageTo": messageTo,
          "messageText": message.text,
          "messageTime": now(),
          "isRead": false
        }).then((value) {
          cs.doc(chatId).update({"lastMessageTime": now()});
        });
        message.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  String replymessageName = "";
  String replymessage = "";

  sendReply(message, replymessage, replymessageName) async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        await cs.doc(chatId).collection('chatting').add({
          "reply": replymessage,
          "replyId": replymessageName,
          "messageFrom": messageFrom,
          "messageTo": messageTo,
          "messageText": message.text,
          "messageTime": now(),
          "isRead": false
        }).then((value) {
          cs.doc(chatId).update({"lastMessageTime": now()});
        });
        message.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  isRead() async {
    print('heelo');
    print(messageTo);
    print(chatId);

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
