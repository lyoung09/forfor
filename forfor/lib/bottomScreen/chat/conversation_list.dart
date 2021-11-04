import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'chatDatabase/chat_firebase.dart';
import 'chatting_detail.dart';

class ConversationList extends StatefulWidget {
  String lastTime;
  final String roomId;
  int pin;
  List<dynamic> talker;
  //bool isMessageRead;
  ConversationList({
    required this.roomId,
    required this.lastTime,
    required this.talker,
    required this.pin,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  final controller = Get.put(AuthController());
  var messageController;
  late String uid;
  late String chatId, chatUserUrl, chatUserName;
  final SlidableController slidableController = SlidableController();
  final _firebase = FirebaseFirestore.instance;

  @override
  void initState() {
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

  pinRoom(roomId) async {
    await _firebase.collection('message').doc(roomId).update({"pin": 0});
  }

  pinEraseRoom(roomId) async {
    await _firebase.collection('message').doc(roomId).update({"pin": 1});
  }

  deleteRoom(roomId) async {
    await _firebase.collection('message').doc(roomId).delete();
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
                  child: GestureDetector(
                    onTap: () {
                      print("12");
                    },
                    child: Slidable(
                      key: Key(snapshot.data!.docs[count].toString()),
                      //controller: slidableController,
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: <Widget>[
                        widget.pin == 0
                            ? IconSlideAction(
                                caption: 'pin 제거',
                                color: Colors.black45,
                                icon: Icons.push_pin_rounded,
                                onTap: () {
                                  pinEraseRoom(widget.roomId);
                                },
                              )
                            : IconSlideAction(
                                caption: 'Pin',
                                color: Colors.black45,
                                icon: Icons.push_pin_outlined,
                                onTap: () {
                                  pinRoom(widget.roomId);
                                },
                              ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            deleteRoom(widget.roomId);
                          },
                        ),
                      ],
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChattingDetail(
                              chatId: widget.roomId,
                              messageTo: chatId,
                              messageFrom: uid,
                            );
                          }));
                        },
                        leading: FutureBuilder<DocumentSnapshot>(
                            future: UserDatabase().getUserDs(chatId),
                            builder: (context, ss) {
                              if (!ss.hasData) {
                                return Container(
                                  width: 0,
                                  height: 0,
                                );
                              }

                              return CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.amber,
                                backgroundImage: NetworkImage(ss.data!["url"]),
                              );
                            }),
                        title: FutureBuilder<DocumentSnapshot>(
                            future: UserDatabase().getUserDs(chatId),
                            builder: (context, ss) {
                              if (!ss.hasData) {
                                return Container();
                              }

                              return Text(
                                ss.data!["nickname"],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                              );
                            }),
                        subtitle: snapshot.data!.docs[count]["messageText"] ==
                                null
                            ? Text("[image]",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                                maxLines: 1)
                            : Text(snapshot.data!.docs[count]["messageText"],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                                maxLines: 1),
                        trailing: Text("${widget.lastTime}"),
                      ),
                    ),
                  ),
                );
                // return FutureBuilder<DocumentSnapshot>(
                //     future: UserDatabase().getUserDs(chatId),
                //     // stream: FirebaseFirestore.instance
                //     //     .collection('users')
                //     //     .doc(chatId)
                //     //     .snapshots(),
                //     builder: (context,  ss) {
                //       if (!ss.hasData) {
                //         Text("");
                //       }

                //       return ListTile(
                //         leading: ss.data!["url"] == null
                //             ? CircleAvatar(
                //                 backgroundColor: Colors.amber,
                //               )
                //             : CircleAvatar(
                //                 backgroundColor: Colors.amber,
                //                 backgroundImage:
                //                     NetworkImage(ss.data!["url"]),
                //               ),
                //         title: ss.data!["nickname"] == null
                //             ? Text("")
                //             : Text(ss.data!["nickname"]),
                //         subtitle:
                //             Text(snapshot.data!.docs[count]["messageText"]),
                //         trailing: Text("26th oct"),
                //       );
                //     });
              });
        });
  }
}
