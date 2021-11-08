import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/controller/chatting/chatcontroller.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/service/chat_firebase_api.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/utils/datetime.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'chatDatabase/chat_firebase.dart';
import 'chatting_detail.dart';

class ConversationList extends StatefulWidget {
  Timestamp lastTime;
  String roomId;
  int pin;
  String talker;
  String nickname;
  String url;
  Key? key;
  final SlidableController controller;
  //bool isMessageRead;
  ConversationList(
      {required this.roomId,
      required this.lastTime,
      required this.talker,
      required this.pin,
      required this.nickname,
      required this.controller,
      required this.url,
      this.key});
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
    oo();
    super.initState();
  }

  String? introduction;
  String? country;
  String? address;
  String? time;
  oo() async {
    var ll = await UserDatabase().getUserDs(widget.talker);

    setState(() {
      introduction = ll.get('introduction');
      country = ll.get('country');
      address = ll.get('address');
    });
  }

  Future<DocumentSnapshot<Object?>> user() async {
    return UserDatabase().getUserDs(widget.talker);
  }

  pinRoom(roomId) async {
    await _firebase.collection('message').doc(roomId).update({"pin": 0});
  }

  pinEraseRoom(roomId) async {
    await _firebase.collection('message').doc(roomId).update({"pin": 1});
  }

  deleteRoom(roomId) async {
    await _firebase
        .collection('message')
        .doc(roomId)
        .collection('chatting')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await _firebase.collection('message').doc(roomId).delete();
  }

  otherProfile() {
    Get.to(() => OtherProfile(
        uid: widget.talker,
        userName: widget.nickname,
        userImage: widget.url,
        introduction: introduction!,
        country: country!,
        address: address!));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.key,
      child: StreamBuilder<QuerySnapshot>(
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
                itemBuilder: (BuildContext context, count) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      key: Key(snapshot.data!.docs[count].id),
                      controller: widget.controller,
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: <Widget>[
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
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            deleteRoom(widget.roomId);
                          },
                        ),
                      ],
                      child: Builder(
                          key: Key(snapshot.data!.docs[count].id),
                          builder: (context) {
                            final slidable = Slidable.of(context)!;
                            final isSlide = slidable.renderingMode ==
                                SlidableRenderingMode.slide;
                            return ListTile(
                              onTap: () {
                                if (isSlide) {
                                  slidable.close();
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ChattingDetail(
                                        chatId: widget.roomId,
                                        messageTo: widget.talker,
                                        messageFrom: controller.user!.uid,
                                        lastTime: widget.lastTime);
                                  }));
                                }
                              },
                              //
                              // onTap: () {
                              //   Get.to(() => OtherProfile(
                              //       uid: user.get('uid'),
                              //       userName: user.get('nickname'),
                              //       userImage: user.get('url'),
                              //       introduction: user.get('introduction'),
                              //       country: user.get('country'),
                              //       address: user.get('address')));
                              // },
                              // child: CircleAvatar(
                              //   radius: 35,
                              //   backgroundColor: Colors.amber,
                              //   backgroundImage:
                              //       NetworkImage(user.get("url") ?? ""),
                              // ),
                              //
                              leading: GestureDetector(
                                onTap: otherProfile,
                                child: widget.url.isEmpty
                                    ? Text("")
                                    : CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.amber,
                                        backgroundImage:
                                            NetworkImage(widget.url)),
                              ),
                              title: widget.pin == 0
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.nickname,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 7)),
                                              CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor:
                                                      Colors.orange[50],
                                                  child: Icon(
                                                      Icons.push_pin_outlined,
                                                      color: Colors.black,
                                                      size: 15))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            widget.nickname,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                              subtitle: snapshot.data!.docs[count]
                                          ["messageText"] ==
                                      null
                                  ? Text("[image]",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      maxLines: 1)
                                  : Text(
                                      snapshot.data!.docs[count]["messageText"],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      maxLines: 1),
                              trailing: Text(widget.lastTime == null
                                  ? ""
                                  : "${DatetimeFunction().ago(widget.lastTime)}"),
                            );
                          }),
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
          }),
    );
  }
}
