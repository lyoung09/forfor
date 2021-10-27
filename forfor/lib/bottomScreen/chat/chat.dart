import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/chatcontroller.dart';

import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import 'body.dart';
import 'conversation_list.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({Key? key}) : super(key: key);

  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  final controller = Get.put(AuthController());
  final messageController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SafeArea(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 20, bottom: 15),
                    child: Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                    EdgeInsets.only(top: 16, left: 25, right: 25, bottom: 16),
                child: TextFormField(
                  cursorColor: Colors.black26,
                  decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),

              // GetX<ChatController>(
              //   init: Get.put<ChatController>(ChatController()),
              //   builder: (ChatController chatController) {
              //     if (chatController.todos.isNotEmpty) {
              //       return ChatBodyWidget(users: chatController.todos);
              //     } else {
              //       return Text("loading...");
              //     }
              //   },
              // ),

              Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: messageController.todos.length,
                  itemBuilder: (context, count) {
                    final user = messageController.todos[count];
                    return ConversationList(
                        name: user.name!,
                        messageText: user.messageText!,
                        imageUrl: user.urlAvatar!,
                        time: user.idUser!,
                        isMessageRead: true);
                  })),
            ])));
  }
}
