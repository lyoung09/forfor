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

  //bool isMessageRead;
  ConversationList({
    required this.messageTo,
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
    hoit();

    super.initState();
  }

  late DocumentReference ds;
  hoit() async {
    ds = FirebaseFirestore.instance
        .collection('message')
        .doc('${widget.messageTo}-${controller.user!.uid}');
    bool docExists = await checkIfDocExists(ds);

    if (docExists) {
      uid = controller.user!.uid;
      chatId = widget.messageTo;
    } else {
      uid = widget.messageTo;
      chatId = controller.user!.uid;
    }
    ds = FirebaseFirestore.instance
        .collection('message')
        .doc('${chatId}-${uid}');
  }

  Future<bool> checkIfDocExists(ds) async {
    try {
      var doc = await ds.get();

      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChattingDetail(
            messageTo: widget.messageTo,
            messageFrom: controller.user!.uid,
          );
        }));
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: ds
              .collection("${chatId}-${uid}")
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
                  return ListTile(
                    leading: Text(snapshot.data!.docs[count]["messageText"]),
                  );
                });
          }),
    );
  }
}
