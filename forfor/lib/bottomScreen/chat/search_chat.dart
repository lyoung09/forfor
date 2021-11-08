import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
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
  String talker;
  int? pin;
  //bool isMessageRead;
  SearchChat({
    required this.roomId,
    required this.userName,
    required this.userAvatar,
    required this.lastTime,
    required this.talker,
    required this.pin,
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
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    time = DatetimeFunction().ago(widget.lastTime);
    oo();

    super.initState();
  }

  String? introduction;
  String? country;
  String? address;
  oo() async {
    var ll = await UserDatabase().getUserDs(widget.talker);

    setState(() {
      introduction = ll.get('introduction');
      country = ll.get('country');
      address = ll.get('address');
    });
  }

  otherProfile() {
    Get.to(() => OtherProfile(
        uid: widget.talker,
        userName: widget.userName,
        userImage: widget.userAvatar,
        introduction: introduction!,
        country: country!,
        address: address!));
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
              itemBuilder: (BuildContext context, count) {
                print(snapshot.data!.docs[count].id);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    key: Key(snapshot.data!.docs[count].id),
                    controller: slidableController,
                    actionPane: SlidableDrawerActionPane(
                      key: Key(snapshot.data!.docs[count].id),
                    ),
                    child: Builder(
                        key: Key(widget.roomId),
                        builder: (context) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChattingDetail(
                                    chatId: widget.roomId,
                                    messageTo: widget.talker,
                                    messageFrom: controller.user!.uid,
                                    lastTime: widget.lastTime);
                              }));
                            },
                            leading: GestureDetector(
                              onTap: otherProfile,
                              child: widget.userAvatar.isEmpty
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.amber,
                                      backgroundImage:
                                          NetworkImage(widget.userAvatar)),
                            ),
                            title: widget.pin == 0
                                ? Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          children: [
                                            Text(
                                              widget.userName,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 7)),
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
                                          widget.userName,
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
              });
        });
  }
}
