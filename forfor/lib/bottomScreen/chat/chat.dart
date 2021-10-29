import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:forfor/controller/user/usercontroller.dart';

import 'package:forfor/model/chat/chatUser.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';

import 'body.dart';
import 'conversation_list.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({Key? key}) : super(key: key);

  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  final chatController = Get.put(ChatController());
  final controller = Get.put(AuthController());
  bool search = false;
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.clear();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 15),
                  child: Text(
                    "Conversations",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              )),

              Padding(
                padding:
                    EdgeInsets.only(top: 16, left: 25, right: 25, bottom: 16),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        search = true;
                      });
                      return null;
                    }
                    if (value.isEmpty) {
                      setState(() {
                        search = false;
                      });
                      return null;
                    }
                    return null;
                  },
                  cursorColor: Colors.black26,
                  decoration: InputDecoration(
                    hintText: "write",
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

              // StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('message')
              //         .where("chattingWith",
              //             arrayContains: controller.user!.uid)
              //         .snapshots(),
              //     builder: (context, AsyncSnapshot<QuerySnapshot> tt) {
              //       if (!tt.hasData) {
              //         return Container();
              //       }
              //       return ListView.builder(
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: tt.data!.size,
              //           itemBuilder: (context, count) {
              //             // List<dynamic> st =
              //             //     tt.data!.docs[count]["chattingWith"];
              //             // String uid, chatId;
              //             // if (st[0] == controller.user!.uid) {
              //             //   uid = st[0];
              //             //   chatId = st[1];
              //             // }
              //             // uid = st[1];
              //             // chatId = st[0];
              //             print(tt.data!.docs[count]["chattingWith"]);
              //             print(tt.data!.docs[count]["lastMessageTime"]);
              //             print(tt.data!.docs[count].id);
              //             return ConversationList(
              //               talker: tt.data!.docs[count]["chattingWith"],
              //               lastTime: tt.data!.docs[count]["lastMessageTime"],
              //               roomId: tt.data!.docs[count].id,
              //             );
              //           });
              //     })
              search == true
                  ? Container(
                      height: 20,
                      width: 20,
                      child: Text("@!211"),
                    )
                  : Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: chatController.todos.length,
                      itemBuilder: (context, count) {
                        return ConversationList(
                          talker: chatController.todos[count].chattingwith!,
                          lastTime: chatController.todos[count].lastTime!,
                          roomId: chatController.todos[count].chatRoomId!,
                        );
                      }))
            ])));
  }
}
