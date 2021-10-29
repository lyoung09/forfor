import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:get/get.dart';

class ChattingDetail extends StatefulWidget {
  final String messageFrom;
  final String messageTo;
  final String chatUserName;
  final String chatUserUrl;
  String? chatId;
  ChattingDetail(
      {Key? key,
      required this.messageTo,
      required this.messageFrom,
      required this.chatUserName,
      required this.chatUserUrl,
      this.chatId})
      : super(key: key);

  @override
  _ChattingDetailState createState() => _ChattingDetailState();
}

class _ChattingDetailState extends State<ChattingDetail> {
  final _firestore = FirebaseFirestore.instance;

  TextEditingController message = new TextEditingController();
  late DocumentReference ds;

  late bool exist;
  final me = Get.put(AuthController());
  ScrollController _controller = ScrollController();

  @override
  initState() {
    super.initState();
    ds = _firestore.collection('message').doc(widget.chatId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  sendMessage() async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        DateTime currentPhoneDate = DateTime.now(); //DateTime

        Timestamp myTimeStamp =
            Timestamp.fromDate(currentPhoneDate); //To TimeStamp

        DateTime myDateTime = myTimeStamp.toDate();

        await ds.collection('chatting').add({
          "messageFrom": widget.messageFrom,
          "messageTo": widget.messageTo,
          "messageText": message.text,
          "messageTime": myDateTime,
        });
        message.clear();
        Timer(Duration(milliseconds: 500),
            () => _controller.jumpTo(_controller.position.minScrollExtent));

        await ds.update({"lastMessageTime": myDateTime});
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "${widget.chatUserName}",
            style: TextStyle(color: Colors.black54, fontSize: 25),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black54),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: ds
                .collection('chatting')
                .orderBy('messageTime', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Stack(
                children: <Widget>[
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 12,
                    ),
                    controller: _controller,
                    reverse: true,
                    itemCount: snapshot.data!.size,
                    //shrinkWrap: true,
                    padding: EdgeInsets.only(
                        top: 10, bottom: 80, left: 10, right: 10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: snapshot.data!.docs[index]
                                        ["messageFrom"] ==
                                    me.user!.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              snapshot.data!.docs[index]["messageFrom"] !=
                                      widget.messageFrom
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 5),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            NetworkImage(widget.chatUserUrl),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: snapshot.data!.docs[index]
                                              ["messageFrom"] !=
                                          widget.messageFrom
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(20.0),
                                          topLeft: Radius.circular(30.0),
                                        )
                                      : BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30.0),
                                          bottomRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                  color: (snapshot.data!.docs[index]
                                              ["messageFrom"] !=
                                          widget.messageFrom
                                      ? Colors.white70
                                      : Colors.orange[50]),
                                ),
                                padding: snapshot.data!.docs[index]
                                            ["messageFrom"] !=
                                        widget.messageFrom
                                    ? EdgeInsets.only(
                                        left: 12,
                                        right: 17.5,
                                        top: 15,
                                        bottom: 15)
                                    : EdgeInsets.only(
                                        left: 17.5,
                                        right: 12,
                                        top: 15,
                                        bottom: 15),
                                child: Text(
                                  snapshot.data!.docs[index]["messageText"],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              // Container(
                              //     child: Text(
                              //   snapshot.data!.docs[index]["messageTime"]
                              //       .toString(),
                              //   style: TextStyle(fontSize: 15),
                              // ))
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                Timer(
                                    Duration(milliseconds: 300),
                                    () => _controller.jumpTo(
                                        _controller.position.minScrollExtent));
                              },
                              controller: message,
                              validator: (value) {
                                if (value!.isNotEmpty) message.text = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: sendMessage,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
