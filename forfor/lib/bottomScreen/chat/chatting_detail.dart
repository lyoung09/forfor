import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/model/chat/chatMessage.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';

class ChattingDetail extends StatefulWidget {
  final String messageFrom;
  final String messageTo;
  String? chatId;
  ChattingDetail(
      {Key? key,
      required this.messageTo,
      required this.messageFrom,
      this.chatId})
      : super(key: key);

  @override
  _ChattingDetailState createState() => _ChattingDetailState();
}

class _ChattingDetailState extends State<ChattingDetail> {
  final _firestore = FirebaseFirestore.instance;
  final userController = Get.put(UserController());
  TextEditingController message = new TextEditingController();
  late DocumentReference ds;
  late DateTime myDateTime;

  @override
  initState() {
    super.initState();

    if (widget.chatId == null) {
      firstMeet();
    } else {
      ds = _firestore.collection('message').doc(widget.chatId);
    }
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    myDateTime = myTimeStamp.toDate();
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists() async {
    try {
      var doc = await ds.get();

      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  firstMeet() async {
    // await _firestore.collection('users').doc(widget.messageFrom).update({
    //   "chattingWith": FieldValue.arrayUnion([widget.messageTo])
    // });
    // await _firestore.collection('users').doc(widget.messageTo).update({
    //   "chattingWith": FieldValue.arrayUnion([widget.messageFrom])
    // });
    var z = await _firestore.collection('message').add({
      "lastMessageTime": null,
      "chattingWith":
          FieldValue.arrayUnion([widget.messageFrom, widget.messageTo])
    });
    ds = _firestore.collection('message').doc(z.id);
  }

  sendMessage() async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        // bool docExists = await checkIfDocExists();
        // if (!docExists) firstMeet();

        await ds.collection('chatting').add({
          "messageFrom": widget.messageFrom,
          "messageTo": widget.messageTo,
          "messageText": message.text,
          "messageTime": myDateTime,
        });

        await ds.update({"lastMessageTime": myDateTime});

        message.clear();
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
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(widget.messageFrom),
                  //   maxRadius: 20,
                  // ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.messageFrom,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: ds
                .collection('chatting')
                .orderBy('messageTime', descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Stack(
                children: <Widget>[
                  ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.size,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: snapshot.data!.docs[index]
                                    ["messageFrom"] !=
                                widget.messageFrom
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          snapshot.data!.docs[index]["messageFrom"] !=
                                  widget.messageFrom
                              ? CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(widget.messageFrom),
                                )
                              : Container(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (snapshot.data!.docs[index]
                                          ["messageFrom"] !=
                                      widget.messageFrom
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              snapshot.data!.docs[index]["messageText"],
                              style: TextStyle(fontSize: 15),
                            ),
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
