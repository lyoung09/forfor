import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forfor/bottomScreen/chat/chatDatabase/chat_firebase.dart';
import 'package:forfor/bottomScreen/chat/widget/reply_widget.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/integration/app_localizations.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/utils/date_formatter.dart';
import 'package:forfor/utils/datetime.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

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

  TextEditingController message = new TextEditingController();
  late DocumentReference ds;
  late DocumentReference userDs;
  bool canSend = false;
  late bool exist;
  final me = Get.put(AuthController());
  ScrollController _controller = ScrollController();
  bool reply = false;
  late bool isShowSticker;
  FocusNode _focus = new FocusNode();
  late ChatFirebase x;

  @override
  initState() {
    super.initState();
    isShowSticker = false;

    x = ChatFirebase(
        messageTo: widget.messageTo,
        messageFrom: widget.messageFrom,
        chatId: widget.chatId!);
    userDs =
        FirebaseFirestore.instance.collection('users').doc(widget.messageTo);
    ds = _firestore.collection('message').doc(widget.chatId);
  }

  sendPic() async {
    x.imgFromGallery();
    changeController();
    FocusManager.instance.primaryFocus!.unfocus();
  }

  _onEmojiSelected(Emoji emoji) {
    message
      ..text += emoji.emoji
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: message.text.length));
  }

  _onBackspacePressed() {
    message
      ..text = message.text.characters.skipLast(1).toString()
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: message.text.length));
  }

  File? _file;
  var _image;
  String urlProfileImageApi = "";

  _imgFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    _file = imageFile != null ? File(imageFile.path) : null;

    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate();
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("chatting/${widget.chatId}/${myDateTime}");

      await ref.putFile(_file!);

      urlProfileImageApi = await ref.getDownloadURL().then((value) {
        return value;
      });
      await ds.collection('chatting').add({
        "messageFrom": widget.messageFrom,
        "messageTo": widget.messageTo,
        "messageUrl": urlProfileImageApi,
        "messageTime": myDateTime,
        "messageText": null,
        "replyName": "",
        "isRead": false
      });
      message.clear();
      Timer(Duration(milliseconds: 500),
          () => _controller.jumpTo(_controller.position.minScrollExtent));

      await ds.update({"lastMessageTime": myDateTime});
    } catch (e) {
      print(e);
    }
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
          "reply": "",
          "replyId": "",
          "messageFrom": widget.messageFrom,
          "messageTo": widget.messageTo,
          "messageText": message.text,
          "messageTime": myDateTime,
          "isRead": false
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

  String replymessageName = "";
  String replymessage = "";

  sendReply(replymessage) async {
    if (message.text.trim().isEmpty) {
    } else {
      try {
        DateTime currentPhoneDate = DateTime.now(); //DateTime

        Timestamp myTimeStamp =
            Timestamp.fromDate(currentPhoneDate); //To TimeStamp

        DateTime myDateTime = myTimeStamp.toDate();

        await ds.collection('chatting').add({
          "reply": replymessage,
          "replyId": replymessageName,
          "messageFrom": widget.messageFrom,
          "messageTo": widget.messageTo,
          "messageText": message.text,
          "messageTime": myDateTime,
          "isRead": false
        });
        message.clear();
        Timer(Duration(milliseconds: 500),
            () => _controller.jumpTo(_controller.position.minScrollExtent));

        await ds.update({"lastMessageTime": myDateTime});
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      reply = false;
      replymessage = "";
      replymessageName = "";
    });
  }

  changeController() {
    Timer(Duration(milliseconds: 500),
        () => _controller.jumpTo(_controller.position.minScrollExtent));
  }

  Widget myWidget(snapshot, index) {
    return SwipeTo(
      onLeftSwipe: () {
        setState(() {
          isShowSticker = false;

          if (snapshot.data!.docs[index]["messageText"] == null ||
              snapshot.data!.docs[index]["messageText"] == "") {
            replyStory = "image";
            replymessage = snapshot.data!.docs[index]["messageUrl"];
          } else {
            replyStory = "text";
            replymessage = snapshot.data!.docs[index]["messageText"];
          }

          reply = true;
        });
        _focus.requestFocus();
      },
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(right: 6),
                child: snapshot.data!.docs[index]["isRead"] == true
                    ? Text(
                        "",
                        style: TextStyle(fontSize: 15),
                      )
                    : Text("1")),
            snapshot.data!.docs[index]["messageText"] == null
                ? Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    height: 150,
                    width: 130,
                    child:
                        Image.network(snapshot.data!.docs[index]["messageUrl"]))
                : Container(
                    width: snapshot.data!.docs[index]["messageText"].length > 15
                        ? 180
                        : null,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        color: Colors.orange[50]),
                    padding: EdgeInsets.only(
                        right: 12, left: 10, top: 15, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        snapshot.data!.docs[index]["reply"] != null &&
                                snapshot.data!.docs[index]["reply"] != ""
                            ? replyExpand(snapshot, index)
                            : Container(height: 0),
                        Text(
                          snapshot.data!.docs[index]["messageText"],
                          maxLines: null,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              snapshot.data!.docs[index]["messageTime"] == null
                  ? ""
                  : "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[index]["messageTime"].toDate().toString()))}",
              style: TextStyle(fontSize: 15),
            ))
      ]),
    );
  }

  Widget otherWidget(snapshot, index) {
    return SwipeTo(
        onRightSwipe: () {
          setState(() {
            isShowSticker = false;

            if (snapshot.data!.docs[index]["messageText"] == null ||
                snapshot.data!.docs[index]["messageText"] == "") {
              replyStory = "image";
              replymessage = snapshot.data!.docs[index]["messageUrl"];
            } else {
              replyStory = "text";
              replymessage = snapshot.data!.docs[index]["messageText"];
            }

            reply = true;
          });
          _focus.requestFocus();
        },
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: userDs.snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot.data!["url"]),
                        ));
                  }),
              snapshot.data!.docs[index]["messageText"] == null
                  ? Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      height: 130,
                      width: 150,
                      child: Image.network(
                          snapshot.data!.docs[index]["messageUrl"]))
                  : Container(
                      width:
                          snapshot.data!.docs[index]["messageText"].length > 15
                              ? 180
                              : null,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                          color: Colors.white70),
                      padding: EdgeInsets.only(
                          left: 17.5, right: 12, top: 15, bottom: 15),
                      child: Column(
                        children: [
                          snapshot.data!.docs[index]["reply"] != null &&
                                  snapshot.data!.docs[index]["reply"] != ""
                              ? replyExpand(snapshot, index)
                              : Container(height: 0),
                          Text(
                            snapshot.data!.docs[index]["messageText"],
                            maxLines: null,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    )
            ],
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                snapshot.data!.docs[index]["messageTime"] == null
                    ? ""
                    : "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[index]["messageTime"]!.toDate().toString()))}",
                style: TextStyle(fontSize: 15),
              ))
        ]));
  }

  Widget replyExpand(snapshot, index) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 120,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('${snapshot.data!.docs[index]["replyId"]}에게 답장',
                style: TextStyle(color: Colors.black54)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(snapshot.data!.docs[index]["reply"],
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.grey[400])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
        ],
      ),
    );
  }

  Widget replyKeyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          height: replyStory == "text" ? 80 : 130,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${replymessageName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        iconSize: 12,
                        icon: Icon(Icons.ac_unit),
                        onPressed: () {
                          setState(() {
                            reply = false;
                          });
                        }),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: replyStory == "text"
                    ? Text(replymessage,
                        style: TextStyle(color: Colors.black54))
                    : Image.network(
                        replymessage,
                        width: 70,
                        height: 60,
                      ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: sendPic,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/album.svg",
                    fit: BoxFit.fitWidth,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focus,
                  readOnly: isShowSticker ? true : false,
                  onTap: () {
                    setState(() {
                      isShowSticker = false;
                    });

                    Timer(
                        Duration(milliseconds: 300),
                        () => _controller
                            .jumpTo(_controller.position.minScrollExtent));
                  },
                  controller: message,
                  onChanged: (xy) {
                    if (xy.isEmpty) {
                      setState(() {
                        canSend = false;
                      });
                    }
                    if (xy.isNotEmpty) {
                      setState(() {
                        canSend = true;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      message.text = value;
                    }
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
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 1.0),
                  child: new IconButton(
                    icon: new Icon(Icons.face),
                    onPressed: () {
                      setState(() {
                        isShowSticker = !isShowSticker;
                      });
                      if (isShowSticker) {
                        Timer(Duration(milliseconds: 2500), () {
                          _focus.requestFocus();
                        });
                      }
                      if (!isShowSticker) {
                        Timer(Duration(milliseconds: 2500), () {
                          _focus.requestFocus();
                        });
                      }
                    },
                    color: Colors.blueGrey,
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: canSend != true ? Colors.grey[300] : Colors.black,
                iconSize: 15,
                onPressed: () {
                  x.sendReply(message, replymessage, replymessageName);
                  changeController();
                  setState(() {
                    reply = false;
                    isShowSticker = false;
                    replymessage = "";
                    replymessageName = "";
                  });
                  _focus.unfocus();
                },
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !isShowSticker,
          child: SizedBox(
            height: 200,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  setState(() {
                    canSend = true;
                  });
                  _onEmojiSelected(emoji);
                },
                onBackspacePressed: _onBackspacePressed,
                config: Config(
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.blue,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    noRecentsText: 'No Recents',
                    noRecentsStyle:
                        const TextStyle(fontSize: 20, color: Colors.black26),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        )
      ],
    );
  }

  Widget keyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 15, top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: sendPic,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/album.svg",
                    fit: BoxFit.fitWidth,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  readOnly: isShowSticker ? true : false,
                  onTap: () {
                    setState(() {
                      isShowSticker = false;
                    });
                    Timer(
                        Duration(milliseconds: 300),
                        () => _controller
                            .jumpTo(_controller.position.minScrollExtent));
                  },
                  controller: message,
                  onChanged: (xy) {
                    if (xy.isNotEmpty) {
                      setState(() {
                        canSend = true;
                      });
                    }
                    if (xy.isEmpty) {
                      setState(() {
                        canSend = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      message.text = value;
                    }
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
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 1.0),
                  child: new IconButton(
                    icon: new Icon(Icons.face),
                    onPressed: () {
                      setState(() {
                        isShowSticker = !isShowSticker;
                        Timer(Duration(milliseconds: 2500), () {
                          FocusScope.of(context).requestFocus();
                        });
                      });
                    },
                    color: Colors.blueGrey,
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: canSend != true ? Colors.grey[300] : Colors.black,
                iconSize: 15,
                onPressed: () {
                  x.sendMessage(message);
                  changeController();
                },
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !isShowSticker,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
                onBackspacePressed: _onBackspacePressed,
                config: Config(
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.blue,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    noRecentsText: 'No Recents',
                    noRecentsStyle:
                        const TextStyle(fontSize: 20, color: Colors.black26),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        )
      ],
    );
  }

  String replyStory = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: StreamBuilder<DocumentSnapshot>(
            stream: userDs.snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              replymessageName = snapshot.data!["nickname"];
              return Text(
                snapshot.data!["nickname"],
                style: TextStyle(color: Colors.black54, fontSize: 25),
              );
            }),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            Get.to(() => BottomNavigation(index: 1));
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.settings, color: Colors.black54),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ],
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
                  padding: reply == true && isShowSticker == false
                      ? EdgeInsets.only(
                          top: 10, bottom: 150, left: 10, right: 10)
                      : reply == false && isShowSticker == false
                          ? EdgeInsets.only(
                              top: 10, bottom: 80, left: 10, right: 10)
                          : reply == true && isShowSticker == true
                              ? EdgeInsets.only(
                                  top: 10, bottom: 420, left: 10, right: 10)
                              :
                              //그 리플없이 이모티콘만
                              EdgeInsets.only(
                                  top: 10, bottom: 320, left: 10, right: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    x.isRead();
                    // if (widget.messageTo ==
                    //     snapshot.data!.docs[index]["messageFrom"]) {
                    //   FirebaseFirestore.instance
                    //       .collection('message')
                    //       .doc(widget.chatId)
                    //       .collection('chatting')
                    //       .where('messageFrom', isEqualTo: widget.messageTo)
                    //       .where('isRead', isEqualTo: false)
                    //       .snapshots()
                    //       .listen((value) {
                    //     value.docs.forEach((element) {
                    //       print('123 ${element.id}');
                    //       FirebaseFirestore.instance
                    //           .collection('message')
                    //           .doc(widget.chatId)
                    //           .collection('chatting')
                    //           .doc(element.id)
                    //           .update({"isRead": true});
                    //     });
                    //   });
                    // }

                    return snapshot.data!.docs[index]["messageFrom"] ==
                            widget.messageFrom
                        ? myWidget(snapshot, index)
                        : otherWidget(snapshot, index);

                    // SwipeTo(
                    //   onRightSwipe: () {
                    //     setState(() {
                    //       isShowSticker = false;

                    //       if (snapshot.data!.docs[index]["messageText"] ==
                    //               null ||
                    //           snapshot.data!.docs[index]["messageText"] == "") {
                    //         replyStory = "image";
                    //         replymessage =
                    //             snapshot.data!.docs[index]["messageUrl"];
                    //       } else {
                    //         replyStory = "text";
                    //         replymessage =
                    //             snapshot.data!.docs[index]["messageText"];
                    //       }

                    //       reply = true;
                    //     });

                    //     _focus.requestFocus();
                    //   },
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: snapshot.data!.docs[index]
                    //                     ["messageFrom"] ==
                    //                 me.user!.uid
                    //             ? MainAxisAlignment.end
                    //             : MainAxisAlignment.start,
                    //         children: [
                    //           snapshot.data!.docs[index]["messageFrom"] !=
                    //                   widget.messageFrom
                    //               ? StreamBuilder<DocumentSnapshot>(
                    //                   stream: FirebaseFirestore.instance
                    //                       .collection('users')
                    //                       .doc(widget.messageTo)
                    //                       .snapshots(),
                    //                   builder: (context,
                    //                       AsyncSnapshot<DocumentSnapshot>
                    //                           snapshot) {
                    //                     if (!snapshot.hasData) {
                    //                       return Container();
                    //                     }
                    //                     return Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 8.0, right: 5),
                    //                         child: CircleAvatar(
                    //                           radius: 20,
                    //                           backgroundImage: NetworkImage(
                    //                               snapshot.data!["url"]),
                    //                         ));
                    //                   })
                    //               : Container(
                    //                   alignment: Alignment.centerLeft,
                    //                   padding: EdgeInsets.only(right: 6),
                    //                   child: snapshot.data!.docs[index]
                    //                               ["isRead"] ==
                    //                           true
                    //                       ? Text(
                    //                           "",
                    //                           style: TextStyle(fontSize: 15),
                    //                         )
                    //                       : Text("1")),
                    //           snapshot.data!.docs[index]["messageText"] == null
                    //               ? Container(
                    //                   padding: snapshot.data!.docs[index]
                    //                               ["messageFrom"] !=
                    //                           widget.messageFrom
                    //                       ? EdgeInsets.only(
                    //                           left: 12,
                    //                           right: 17.5,
                    //                           top: 15,
                    //                           bottom: 15)
                    //                       : EdgeInsets.only(
                    //                           left: 17.5,
                    //                           right: 12,
                    //                           top: 15,
                    //                           bottom: 15),
                    //                   height: 130,
                    //                   width: 130,
                    //                   child: Image.network(snapshot
                    //                       .data!.docs[index]["messageUrl"]))
                    //               : Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: snapshot.data!.docs[index]
                    //                                 ["messageFrom"] !=
                    //                             widget.messageFrom
                    //                         ? BorderRadius.only(
                    //                             topRight: Radius.circular(30.0),
                    //                             bottomRight:
                    //                                 Radius.circular(30.0),
                    //                             bottomLeft:
                    //                                 Radius.circular(20.0),
                    //                             topLeft: Radius.circular(30.0),
                    //                           )
                    //                         : BorderRadius.only(
                    //                             topRight: Radius.circular(30.0),
                    //                             topLeft: Radius.circular(30.0),
                    //                             bottomRight:
                    //                                 Radius.circular(20.0),
                    //                             bottomLeft:
                    //                                 Radius.circular(30.0),
                    //                           ),
                    //                     color: (snapshot.data!.docs[index]
                    //                                 ["messageFrom"] !=
                    //                             widget.messageFrom
                    //                         ? Colors.white70
                    //                         : Colors.orange[50]),
                    //                   ),
                    //                   padding: snapshot.data!.docs[index]
                    //                               ["messageFrom"] !=
                    //                           widget.messageFrom
                    //                       ? EdgeInsets.only(
                    //                           left: 12,
                    //                           right: 17.5,
                    //                           top: 15,
                    //                           bottom: 15)
                    //                       : EdgeInsets.only(
                    //                           left: 17.5,
                    //                           right: 12,
                    //                           top: 15,
                    //                           bottom: 15),
                    //                   child:
                    //                   Column(
                    //                     children: [
                    //                       snapshot.data!.docs[index]["reply"] !=
                    //                                   null &&
                    //                               snapshot.data!.docs[index]
                    //                                       ["reply"] !=
                    //                                   ""
                    //                           ? Container(
                    //                               alignment:
                    //                                   Alignment.centerLeft,
                    //                               decoration: BoxDecoration(
                    //                                   border: Border(
                    //                                       bottom: BorderSide(
                    //                                           width: 0.6))),
                    //                               child: Column(
                    //                                 children: [
                    //                                   Text(
                    //                                       snapshot.data!
                    //                                               .docs[index]
                    //                                           ["replyId"],
                    //                                       style: TextStyle(
                    //                                           color: Colors
                    //                                               .black54)),
                    //                                   Padding(
                    //                                     padding:
                    //                                         EdgeInsets.only(
                    //                                             top: 8),
                    //                                   ),
                    //                                   Align(
                    //                                     alignment: Alignment
                    //                                         .centerLeft,
                    //                                     child: Text(
                    //                                         snapshot.data!
                    //                                                 .docs[index]
                    //                                             ["reply"],
                    //                                         maxLines: 1,
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .clip,
                    //                                         style: TextStyle(
                    //                                             color: Colors
                    //                                                 .black54)),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             )
                    //                           : Container(height: 0),
                    //                       Text(
                    //                         snapshot.data!.docs[index]
                    //                             ["messageText"],
                    //                         style: TextStyle(fontSize: 15),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //         ],
                    //       ),
                    //       snapshot.data!.docs[index]["messageFrom"] !=
                    //               widget.messageFrom
                    //           ? Container(
                    //               alignment: Alignment.centerLeft,
                    //               child: Text(
                    //                 snapshot.data!.docs[index]["messageTime"] ==
                    //                         null
                    //                     ? ""
                    //                     : "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[index]["messageTime"]!.toDate().toString()))}",
                    //                 style: TextStyle(fontSize: 15),
                    //               ))
                    //           : Container(
                    //               alignment: Alignment.centerRight,
                    //               child: Text(
                    //                 snapshot.data!.docs[index]["messageTime"] ==
                    //                         null
                    //                     ? ""
                    //                     : "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[index]["messageTime"].toDate().toString()))}",
                    //                 style: TextStyle(fontSize: 15),
                    //               )),
                    //     ],
                    //   ),
                    // );
                  },
                ),
                reply == true ? replyKeyboard() : keyboard(),
              ],
            );
          }),
    );
  }
}
