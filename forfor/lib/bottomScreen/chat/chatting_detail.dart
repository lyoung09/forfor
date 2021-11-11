import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forfor/bottomScreen/chat/chatDatabase/chat_firebase.dart';
import 'package:forfor/bottomScreen/chat/ttt.dart';
import 'package:forfor/bottomScreen/chat/widget/chat_text_input.dart';
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
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChattingDetail extends StatefulWidget {
  final String messageFrom;
  final String messageTo;
  Timestamp? lastTime;
  String? chatId;
  ChattingDetail(
      {Key? key,
      required this.messageTo,
      required this.messageFrom,
      this.lastTime,
      this.chatId})
      : super(key: key);

  @override
  _ChattingDetailState createState() => _ChattingDetailState();
}

class _ChattingDetailState extends State<ChattingDetail> {
  final _firestore = FirebaseFirestore.instance;

  late DocumentReference ds;
  late DocumentReference userDs;
  bool canSend = false;
  late bool exist;
  final me = Get.put(AuthController());
  ScrollController _controller = ScrollController();
  bool reply = false;
  late bool isShowSticker;
  bool isKeyboardVisible = false;
  Key _formKey = new UniqueKey();
  FocusNode _focus = new FocusNode();
  late ChatFirebase x;
  String? replyImage;
  final TextEditingController _message = new TextEditingController();
  String? replyStory;

  @override
  initState() {
    isShowSticker = false;
    super.initState();

    x = ChatFirebase(
        messageTo: widget.messageTo,
        messageFrom: widget.messageFrom,
        chatId: widget.chatId!);
    userDs =
        FirebaseFirestore.instance.collection('users').doc(widget.messageTo);
    ds = _firestore.collection('message').doc(widget.chatId);

    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          isShowSticker = false;
        });
      }
    });
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  sendPic() async {
    x.imgFromGallery();
    changeController();
    _focus.unfocus();
  }

  _onEmojiSelected(Emoji emoji) {
    _message
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _message.text.length));
  }

  _onBackspacePressed() {
    _message
      ..text = _message.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _message.text.length));
  }

  String? replymessageName = "";
  String replymessage = "";

  changeController() {
    _controller.jumpTo(_controller.position.minScrollExtent);
  }

  Widget myWidget(snapshot, index) {
    return SwipeTo(
      onLeftSwipe: () {
        setState(() {
          reply = true;

          amI = true;
          if (snapshot.data!.docs[index]["messageText"] == null ||
              snapshot.data!.docs[index]["messageText"] == "") {
            replyStory = "image";
            replyImage = snapshot.data!.docs[index]["messageUrl"];
          } else {
            replyStory = "text";
            replymessage = snapshot.data!.docs[index]["messageText"];
          }
        });

        _focus.requestFocus();
      },
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                snapshot.data!.docs[index]["isRead"] == true
                    ? Text(
                        "",
                      )
                    : Container(
                        padding: EdgeInsets.only(bottom: 5, right: 10),
                        child: Text("1",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500))),
                0 == index && snapshot.data!.docs[index]["messageTime"] != null
                    ? Container(
                        padding: EdgeInsets.only(bottom: 1, right: 10),
                        child: Text(
                          "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[0]["messageTime"]!.toDate().toString()))}",
                          style: TextStyle(fontSize: 15),
                        ))
                    : Container(height: 0)
              ],
            ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.data!.docs[index]["reply"] != null &&
                                    snapshot.data!.docs[index]["reply"] != "" ||
                                snapshot.data!.docs[index]["replyImage"] !=
                                        null &&
                                    snapshot.data!.docs[index]["replyImage"] !=
                                        ""
                            ? replyExpand(snapshot, index)
                            : Container(height: 0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data!.docs[index]["messageText"],
                            maxLines: null,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ]),
    );
  }

  bool? amI;
  Widget otherWidget(snapshot, index) {
    return SwipeTo(
      onRightSwipe: () {
        setState(() {
          reply = true;

          amI = false;
          if (snapshot.data!.docs[index]["messageText"] == null ||
              snapshot.data!.docs[index]["messageText"] == "") {
            replyStory = "image";
            replyImage = snapshot.data!.docs[index]["messageUrl"];
          } else {
            replyStory = "text";
            replymessage = snapshot.data!.docs[index]["messageText"];
          }
        });
        _focus.requestFocus();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: userDs.snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                replymessageName = snapshot.data!["nickname"];
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 5),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(snapshot.data!["url"]),
                      )),
                );
              }),
          snapshot.data!.docs[index]["messageText"] == null
              ? Container(
                  padding: EdgeInsets.only(bottom: 15),
                  height: 130,
                  width: 150,
                  child:
                      Image.network(snapshot.data!.docs[index]["messageUrl"]))
              : Container(
                  alignment: Alignment.centerLeft,
                  width: snapshot.data!.docs[index]["messageText"].length > 15
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
                  padding:
                      EdgeInsets.only(left: 17.5, right: 12, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data!.docs[index]["reply"] != null &&
                                  snapshot.data!.docs[index]["reply"] != "" ||
                              snapshot.data!.docs[index]["replyImage"] !=
                                      null &&
                                  snapshot.data!.docs[index]["replyImage"] != ""
                          ? replyExpand(snapshot, index)
                          : Container(height: 0),
                      Text(
                        snapshot.data!.docs[index]["messageText"],
                        maxLines: null,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              snapshot.data!.docs[index]["isRead"] == true
                  ? Text(
                      "",
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 5, right: 8),
                      child: Text("1",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
              0 == index && snapshot.data!.docs[index]["messageTime"] != null
                  ? Container(
                      padding: EdgeInsets.only(bottom: 1, right: 8),
                      child: Text(
                        "${DatetimeFunction().readTimeStamp(DateTime.parse(snapshot.data!.docs[0]["messageTime"]!.toDate().toString()))}",
                        style: TextStyle(fontSize: 15),
                      ))
                  : Container(
                      height: 0,
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget replyExpand(snapshot, index) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 120,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                snapshot.data!.docs[index]["replyId"] == me.user!.uid
                    ? '나에게 답장'
                    : '${snapshot.data!.docs[index]["replyId"]}에게 답장',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.black54)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: snapshot.data!.docs[index]["reply"] != null &&
                    snapshot.data!.docs[index]["reply"] != ""
                ? Text(snapshot.data!.docs[index]["reply"],
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.grey[400]))
                : snapshot.data!.docs[index]["replyImage"] != null &&
                        snapshot.data!.docs[index]["replyImage"] != ""
                    ? Image.network(
                        snapshot.data!.docs[index]["replyImage"],
                        width: 70,
                        height: 60,
                      )
                    : Text(""),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
        ],
      ),
    );
  }

  Widget chatForm() {
    return  TextFormField(
        key: _formKey,
        readOnly: false,
        maxLines: 5,
        minLines: 1,
        focusNode: _focus,
        onTap: () {
          setState(() {
            if (isShowSticker) {
              isShowSticker = false;
            }
          });
          Timer(Duration(milliseconds: 300),
              () => _controller.jumpTo(_controller.position.minScrollExtent));
        },
        controller: _message,
        validator: (value) {
          if (value!.isNotEmpty) {
            _message.text = value;
          }
          
        },
        onChanged: (ch) {
          setState(() {});
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
        ),
      
    );
  }

  Widget keyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        reply == true
            ? Container(
                height: replyStory == "text" ? 90 : 130,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: amI == true
                              ? Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Text(
                                    "나에게 답장하기",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      replymessageName!.length > 20
                                          ? Text(
                                              "${replymessageName!.substring(0, 20)}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                            )
                                          : Text(
                                              "${replymessageName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                            ),
                                      Text(
                                        "에게 답장하기",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                iconSize: 15,
                                icon: Icon(Icons.close_outlined),
                                onPressed: () {
                                  setState(() {
                                    reply = false;
                                  });

                                  // Timer(
                                  //     Duration(milliseconds: 500),
                                  //     () => _controller.jumpTo(
                                  //         _controller.position.minScrollExtent));
                                }),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: replyStory == "text"
                          ? EdgeInsets.only(left: 25.0)
                          : EdgeInsets.only(left: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: replyStory == "text"
                            ? Text(replymessage,
                                style: TextStyle(color: Colors.black54))
                            : Image.network(
                                replyImage!,
                                width: 120,
                                height: 80,
                              ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(height: 0),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 15, top: 10),
          height: Platform.isAndroid ? 60 : 75,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.photo_size_select_actual_outlined,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              IconButton(
                icon: new Icon(Icons.face),
                onPressed: () {
                  setState(() {
                    _focus.unfocus();
                    _focus.canRequestFocus = false;

                    isShowSticker = !isShowSticker;
                  });
                },
                color: Colors.blueGrey,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 1,
                child: chatForm(),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: _message.text.trim().isEmpty
                    ? Colors.grey[300]
                    : Colors.black,
                iconSize: 18,
                onPressed: () {
                  x.sendMessage(_message);
                  changeController();
                  reply == true
                      ? setState(() {
                          reply = false;
                          if (isShowSticker) {
                            isShowSticker = false;
                          }
                          replymessage = "";
                          replymessageName = "";
                          replyImage = "";
                        })
                      : setState(() {
                          if (isShowSticker) {
                            isShowSticker = false;
                          }
                        });
                },
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        Center(
          child: isShowSticker == true
              ? Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 320,
                    child: EmojiPicker(
                        onEmojiSelected: (Category category, Emoji emoji) {
                          _onEmojiSelected(emoji);
                        },
                        onBackspacePressed: () {
                          _onBackspacePressed();
                        },
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
                            showRecentsTab: false,
                            recentsLimit: 28,
                            noRecentsText: 'No Recents',
                            noRecentsStyle: const TextStyle(
                                fontSize: 20, color: Colors.black26),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL)),
                  ),
                )
              : Text(""),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isShowSticker) {
          setState(() {
            isShowSticker = false;
          });
          _focus.requestFocus();
        } else {
          Get.to(() => BottomNavigation(index: 1));
        }
        return new Future(() => false);
      },
      child: Scaffold(
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

                return Text(
                  snapshot.data!["nickname"],
                  overflow: TextOverflow.clip,
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
                  GestureDetector(
                    onTap: () {
                      if (isShowSticker) {
                        setState(() {
                          isShowSticker = false;
                        });

                        _focus.unfocus();
                      }
                    },
                    child: ListView.separated(
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
                                      top: 10,
                                      bottom: 320,
                                      left: 10,
                                      right: 10),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        x.isRead();
                        Map<int, String> pp = new Map<int, String>();
                        if (snapshot.data!.docs[index]["messageTime"] != null) {
                          Map<int, String> ttt = new Map<int, String>();
                          List<dynamic> aa = [];
                          for (int i = 0; i < snapshot.data!.size; i++) {
                            ttt[i] = DatetimeFunction().diffDay(DateTime.parse(
                                snapshot.data!.docs[i]["messageTime"]!
                                    .toDate()
                                    .toString()));
                          }

                          ttt.forEach((key, value) => aa.add(value));
                          for (int z = snapshot.data!.size - 1; 0 <= z; z--) {
                            if (ttt[z] == aa[z]) {
                              if (pp.containsValue(aa[z]))
                                pp[z] = "";
                              else
                                pp[z] = aa[z];
                            }
                          }
                        } else {
                          pp[index] = "";
                        }
                        return Column(
                          children: [
                            snapshot.data!.docs[index]["messageTime"] != null &&
                                    pp[index]!.isNotEmpty
                                ? Center(
                                    child: Padding(
                                    padding: pp[index] == ""
                                        ? EdgeInsets.all(0)
                                        : EdgeInsets.only(bottom: 30.0),
                                    child: Text(pp[index]!),
                                  ))
                                : Container(
                                    height: 0,
                                  ),
                            snapshot.data!.docs[index]["messageFrom"] ==
                                    widget.messageFrom
                                ? myWidget(snapshot, index)
                                : otherWidget(snapshot, index),
                          ],
                        );
                      },
                    ),
                  ),
                  keyboard(),
                ],
              );
            }),
      ),
    );
  }
}

class Customer {
  String datetime;
  int index;

  Customer(this.index, this.datetime);

  @override
  String toString() {
    return '{ ${this.datetime}, ${this.index} }';
  }
}
