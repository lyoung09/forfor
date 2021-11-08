import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/utils/datetime.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'chatting_detail.dart';

class SearchChat extends StatefulWidget {
  Timestamp lastTime;
  final String roomId;
  String userName;
  String userAvatar;
  List<dynamic> talker;
  //bool isMessageRead;
  SearchChat({
    required this.roomId,
    required this.userName,
    required this.userAvatar,
    required this.lastTime,
    required this.talker,
  });
  @override
  _SearchChatState createState() => _SearchChatState();
}

class _SearchChatState extends State<SearchChat> {
  final controller = Get.put(AuthController());
  var messageController;
  late String uid;
  late String chatId, chatUserUrl, chatUserName;
  late String time;
  @override
  void initState() {
    time = DatetimeFunction().ago(widget.lastTime);
    if (widget.talker[0] == controller.user!.uid) {
      uid = widget.talker[0];
      chatId = widget.talker[1];
    }
    if (widget.talker[1] == controller.user!.uid) {
      chatId = widget.talker[0];
      uid = widget.talker[1];
    } else {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('message')
            .doc(widget.roomId)
            .collection("chatting")
            .orderBy("messageTime", descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data!.size,
              shrinkWrap: true,
              itemBuilder: (context, count) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChattingDetail(
                          chatId: widget.roomId,
                          messageTo: chatId,
                          messageFrom: uid,
                          lastTime: widget.lastTime,
                        );
                      }));
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(widget.userAvatar),
                    ),
                    title: Text(
                      widget.userName,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                    ),
                    subtitle: snapshot.data!.docs[count]["messageText"] == null
                        ? Text("[image]",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            maxLines: 1)
                        : Text(snapshot.data!.docs[count]["messageText"] ?? "",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            maxLines: 1),
                    trailing: Text("${widget.lastTime}"),
                  ),
                );
              });
        });
  }
}
