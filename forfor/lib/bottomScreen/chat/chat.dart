import 'package:flutter/material.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: StreamBuilder<List<ChatUsers>>(
          stream: FirebaseApi.getUsers(controller.user!.uid),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Something Went Wrong Try later');
                } else {
                  final users = snapshot.data;

                  if (users!.isEmpty) {
                    return Text('No Users Found');
                  } else
                    return Column(children: [
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 20, bottom: 15),
                          child: Text(
                            "Conversations",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16, left: 25, right: 25, bottom: 16),
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
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                          ),
                        ),
                      ),
                      ChatBodyWidget(users: users)
                    ]);
                }
            }
          }),
    ));
  }
}
