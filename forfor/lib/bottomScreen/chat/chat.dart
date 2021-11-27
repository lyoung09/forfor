import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forfor/bottomScreen/chat/search_chat.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';

import 'package:forfor/service/chat_firebase_api.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/utils/datetime.dart';
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
  final SlidableController slidableController = SlidableController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _unKey = UniqueKey();
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool enable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
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
                      } else {
                        setState(() {
                          search = false;
                        });
                      }
                    },
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                      hintText: "",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      suffixIcon:
                          searchController.text.trim().isNotEmpty == true
                              ? IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      searchController.clear();
                                      search = false;
                                    });
                                  },
                                  icon: Icon(Icons.close_rounded,
                                      color: Colors.grey.shade600),
                                  iconSize: 20,
                                )
                              : Text(""),
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
                search == true
                    ?
                    //Obx(() => ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: chatController.todos.length,
                    //     itemBuilder: (context, count) {
                    //       return SearchChat(
                    //         search: searchController.text.trim(),
                    //         talker: chatController.todos[count].chattingwith!,
                    //         lastTime: chatController.todos[count].lastTime!,
                    //         roomId: chatController.todos[count].chatRoomId!,
                    //       );
                    //     }))

                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            // .where('chattingWith',
                            //     arrayContains: controller.user!.uid)
                            .where('nickname',
                                isGreaterThanOrEqualTo:
                                    searchController.text.trim())
                            .where('nickname',
                                isLessThan: searchController.text + 'z')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> search) {
                          if (!search.hasData) {
                            return Container();
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: search.data!.size,
                              itemBuilder: (context, number) {
                                List t = [];
                                t.add(
                                  search.data!.docs[number]["uid"],
                                );
                                t.add(controller.user!.uid);

                                return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("message")
                                        .where('chattingWith',
                                            whereIn: [t, t.reversed.toList()])
                                        //.where('pin', isEqualTo: true)
                                        //.orderBy("lastMessageTime", descending: true)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }

                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.size,
                                          itemBuilder: (context, count) {
                                            late String other;
                                            if (chatController.todos[count]
                                                    .chattingwith![0] ==
                                                controller.user!.uid) {
                                              other = chatController
                                                  .todos[count]
                                                  .chattingwith![1];
                                            }
                                            if (chatController.todos[count]
                                                    .chattingwith![1] ==
                                                controller.user!.uid) {
                                              other = chatController
                                                  .todos[count]
                                                  .chattingwith![0];
                                            }

                                            return SearchChat(
                                              pin: snapshot.data!.docs[count]
                                                  ['pin'],
                                              userName: search.data!
                                                  .docs[number]["nickname"],
                                              userAvatar: search
                                                  .data!.docs[number]["url"],
                                              talker: other,
                                              lastTime:
                                                  snapshot.data!.docs[count]
                                                      ["lastMessageTime"],
                                              roomId:
                                                  snapshot.data!.docs[count].id,
                                            );
                                          });
                                    });
                              });
                        })
                    : Form(
                        key: _unKey,
                        child: Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: chatController.todos.length,
                            itemBuilder: (context, count) {
                              late String other;
                              if (chatController
                                      .todos[count].chattingwith![0] ==
                                  controller.user!.uid) {
                                other = chatController
                                    .todos[count].chattingwith![1];
                              }
                              if (chatController
                                      .todos[count].chattingwith![1] ==
                                  controller.user!.uid) {
                                other = chatController
                                    .todos[count].chattingwith![0];
                              }

                              return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(other)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    }
                                    return ConversationList(
                                      controller: slidableController,
                                      key: _unKey,
                                      talker: other,
                                      lastTime:
                                          chatController.todos[count].lastTime!,
                                      roomId: chatController
                                          .todos[count].chatRoomId!,
                                      pin: chatController.todos[count].pin!,
                                      nickname: snapshot.data!["nickname"],
                                      url: snapshot.data!["url"],
                                    );
                                  });
                            })),
                      )
              ]),
            )));
  }
}
