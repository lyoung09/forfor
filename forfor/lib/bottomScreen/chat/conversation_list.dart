import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:get/get.dart';

import 'chatting_detail.dart';

class ConversationList extends StatefulWidget {
  String messageTo;
  List<String> talker;
  //bool isMessageRead;
  ConversationList({
    required this.messageTo,
    required this.talker,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  final controller = Get.put(AuthController());
  var messageController;
  String? uid;
  String? chatId;

  @override
  void initState() {
    if (widget.talker[0] == controller.user!.uid) {
      uid = widget.talker[0];
      chatId = widget.talker[1];
    }
    if (widget.talker[1] == controller.user!.uid) {
      chatId = widget.talker[0];
      uid = widget.talker[1];
    } else {
      print("?");
    }
//    hoit();

    super.initState();
  }

  // hoit() async {
  //   ds = FirebaseFirestore.instance
  //       .collection('message')
  //       .doc('${widget.messageTo}-${controller.user!.uid}');

  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChattingDetail(
            chatId: widget.messageTo,
            messageTo: chatId!,
            messageFrom: uid!,
          );
        }));
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('message')
              .doc(widget.messageTo)
              .collection("chatting")
              .orderBy("messageTime", descending: true)
              .limit(1)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            // return ListView.builder(
            //     shrinkWrap: false,
            //     itemCount: messageController.todos.length,
            //     itemBuilder: (context, count) {
            //       final message = messageController.todos[count];
            //       return Container(
            //         padding:
            //             EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            //         child: Row(
            //           children: <Widget>[
            //             Expanded(
            //               child: Row(
            //                 children: <Widget>[
            //                   //  CircleAvatar(
            //                   //   backgroundImage: NetworkImage(widget.messageFrom),
            //                   //   maxRadius: 30,
            //                   // ),

            //                   SizedBox(
            //                     width: 16,
            //                   ),
            //                   Expanded(
            //                     child: Container(
            //                       color: Colors.transparent,
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: <Widget>[
            //                           Text(
            //                             message.messageFrom!,
            //                             style: TextStyle(fontSize: 16),
            //                           ),
            //                           SizedBox(
            //                             height: 6,
            //                           ),
            //                           Text(
            //                             message.messageText!,
            //                             style: TextStyle(
            //                                 fontSize: 13,
            //                                 color: Colors.grey.shade600,
            //                                 fontWeight:
            //                                     // widget.messageFrom
            //                                     //     ? FontWeight.bold
            //                                     //:
            //                                     FontWeight.normal),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Text(
            //               message.messageTime!.toDate().toString(),
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight:
            //                       // widget.isMessageRead
            //                       //     ? FontWeight.bold
            //                       //     :
            //                       FontWeight.normal),
            //             ),
            //           ],
            //         ),
            //       );
            //     });
            return ListView.builder(
                itemCount: snapshot.data!.size,
                shrinkWrap: true,
                itemBuilder: (context, count) {
                  return snapshot.data!.docs[count].id.isEmpty
                      ? Text("")
                      : ListTile(
                          leading:
                              Text(snapshot.data!.docs[count]["messageText"]),
                        );
                });
          }),
    );
  }
}
