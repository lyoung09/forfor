import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/favoriteList.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/bottomScreen/profile/my_profile.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/service/postingervice.dart';
import 'package:forfor/utils/datetime.dart';
import 'package:forfor/widget/safe_tap.dart';
import 'package:get/get.dart';

class SayReply extends StatefulWidget {
  final String postingId;
  final String userId;
  final String authorId;

  final int replyCount;
  final String story;
  final String time;

  SayReply({
    Key? key,
    required this.postingId,
    required this.userId,
    required this.authorId,
    required this.replyCount,
    required this.story,
    required this.time,
  }) : super(key: key);

  @override
  _SayReplyState createState() => _SayReplyState();
}

class _SayReplyState extends State<SayReply> {
  late bool favoriteThis;
  late FocusNode myFocusNode;
  bool textExist = false;
  TextEditingController _reply = new TextEditingController();

  late DateTime dt;
  CollectionReference _userRef = FirebaseFirestore.instance.collection("users");
  CollectionReference _categoryRef =
      FirebaseFirestore.instance.collection("category");
  CollectionReference _postingRef =
      FirebaseFirestore.instance.collection("posting");
  initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  Map<String, DateTime> favoriteTime = new Map<String, DateTime>();

  reply() async {
    if (_reply.text.trim().isNotEmpty) {
      DateTime currentPhoneDate = DateTime.now(); //DateTime

      Timestamp myTimeStamp =
          Timestamp.fromDate(currentPhoneDate); //To TimeStamp

      DateTime myDateTime = myTimeStamp.toDate(); //

      DocumentReference ref = FirebaseFirestore.instance
          .collection('posting')
          .doc(widget.postingId);

      await ref.update({
        "reply": _reply.text.trim(),
        "replyId": widget.userId,
        "datetime": myDateTime
      });

      _reply.clear();
      myFocusNode.unfocus();
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "글이 있어야합니다",
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        onCancel: () {
          FocusScope.of(context).requestFocus(new FocusNode());

          // Get.back();
        },
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );
    }
  }

  Widget bottom(size) {
    return Container(
      height: Platform.isAndroid ? 70 : 90,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Expanded(
            flex: 7,
            child: TextFormField(
              maxLines: 5,
              minLines: 1,
              controller: _reply,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    textExist = true;
                  });
                }
              },
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                }
                return null;
              },
              focusNode: myFocusNode,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: " reply that question",
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.send_outlined,
                size: 26,
                color: textExist == true ? Colors.grey[900] : Colors.white60,
              ),
              onPressed: textExist == true ? reply : () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget post(post) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _userRef.doc(post["authorId"]).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => OtherProfile(
                              uid: post["authorId"],
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage("${snapshot.data!["url"]}")),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 5,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'icons/flags/png/${snapshot.data!["country"]}.png',
                                    package: 'country_icons'),
                                backgroundColor: Colors.white,
                                radius: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 12)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Text('${snapshot.data!["nickname"]}',
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: _categoryRef
                                .where("categoryId",
                                    isEqualTo: post["category"])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("");
                              }
                              return Text(
                                  snapshot.data!.docs[0]["categoryName"]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black));
                            }),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(widget.time),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(9)),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.story,
                          // "abjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjl",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))),
                ),
                post["images"] == null || post["images"].length == 0
                    ? Text("")
                    : post["images"].length <= 3
                        ? Container(
                            height: 120,
                            child: GridView.builder(
                                shrinkWrap: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: post["images"].length,
                                itemBuilder: (BuildContext context, count) {
                                  return Center(
                                    child: Image.network(post["images"][count],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover),
                                  );
                                }),
                          )
                        : Container(
                            height: 250,
                            child: GridView.builder(
                                shrinkWrap: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: post["images"].length,
                                itemBuilder: (BuildContext context, count) {
                                  return Center(
                                    child: Image.network(post["images"][count],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover),
                                  );
                                }),
                          ),
                Padding(padding: EdgeInsets.all(9)),
                Divider(),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: _postingRef
                            .doc(widget.postingId)
                            .collection('likes')
                            .doc(widget.userId)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> likeUser) {
                          if (!likeUser.hasData) {
                            favoriteThis = false;
                          }
                          if (likeUser.hasData) {
                            favoriteThis = likeUser.data!.exists;

                            return IconButton(
                              onPressed: () {
                                favoriteThis = !favoriteThis;
                                check();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: favoriteThis == true
                                    ? Colors.red[400]
                                    : Colors.grey[300],
                              ),
                            );
                          }
                          return Container();
                        }),
                    SizedBox(
                      width: 15,
                    ),
                    StreamBuilder(
                        stream: PostingService().favorite(widget.postingId),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              snapshot.data!.docs.length < 1
                                  ? ""
                                  : "${snapshot.data!.docs.length.toString()} ",
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }),
                    IconButton(
                      iconSize: 12,
                      icon: Icon(Icons.chat_bubble_outline_outlined),
                      onPressed: () {
                        myFocusNode.requestFocus();
                      },
                    ),
                    Text(
                      post!["replyCount"] == 0 || post!["replyCount"] < 1
                          ? ""
                          : "${post!["replyCount"]} ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 12,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  check() async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); //

    if (favoriteThis) {
      // if (!user.contains(controller.user!.uid))
      FirebaseFirestore.instance
          .collection('posting')
          .doc('${widget.postingId}')
          .collection('likes')
          .doc(widget.userId)
          .set({
        "likeId": widget.userId,
        "likeDatetime": myDateTime,
        "postingId": widget.postingId
      });
    }
    if (!favoriteThis) {
      FirebaseFirestore.instance
          .collection('posting')
          .doc('${widget.postingId}')
          .collection('likes')
          .doc(widget.userId)
          .delete();
    } else {}
  }

  Widget review(count, review) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          Map<int, String> ago = new Map<int, String>();

          ago[index] = DatetimeFunction().ago(review[index]["datetime"]);
          return StreamBuilder<QuerySnapshot>(
              stream: _userRef
                  .where("uid", isEqualTo: review[index]["replyId"])
                  .snapshots(),
              builder: (context, users) {
                if (!users.hasData) {
                  return Container();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: users.data!.size,
                    itemBuilder: (BuildContext context, userCount) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 8)),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => OtherProfile(
                                            uid: review[index]["replyId"],
                                          ));
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  "${users.data!.docs[userCount]["url"]}")),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 5,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'icons/flags/png/${users.data!.docs[userCount]["country"]}.png',
                                                package: 'country_icons'),
                                            backgroundColor: Colors.white,
                                            radius: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: InkWell(
                                onTap: widget.userId ==
                                        users.data!.docs[userCount]["uid"]
                                    ? () {
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) => CupertinoAlertDialog(
                                        //           title: Text('이미지로 저장하시겠습니까?'),
                                        //           actions: <Widget>[
                                        //             CupertinoDialogAction(
                                        //               child: Text('아니요'),
                                        //               onPressed: () => Navigator.of(context).pop(),
                                        //             ),
                                        //             CupertinoDialogAction(
                                        //                 child: Text('네'),
                                        //                 onPressed: () {
                                        //                   Navigator.of(context).pop();
                                        //                 }),
                                        //           ],
                                        //         ));
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              print(MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom);
                                              return SingleChildScrollView(
                                                  child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _postingRef
                                                            .doc(widget
                                                                .postingId)
                                                            .update({
                                                          "replyCount":
                                                              FieldValue
                                                                  .increment(
                                                                      -1),
                                                        });
                                                        _postingRef
                                                            .doc(widget
                                                                .postingId)
                                                            .collection(
                                                                'review')
                                                            .doc(review[index]
                                                                .id)
                                                            .delete();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Center(
                                                            child: Text("삭제",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                            .red[
                                                                        400]))),
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Colors.transparent,
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Center(
                                                            child: Text("취소")),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ));
                                            });
                                      }
                                    : () {},
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 10),
                                        child: Text(
                                            users.data!.docs[userCount]
                                                ["nickname"],
                                            // "helelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelel",
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          review[index]["reply"],
                                          //"helelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelel",

                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0, right: 16),
                              child: Text("${ago[index]}",
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ],
                        ),
                      );
                    });
              });
        });
  }

  Widget likesUser(likesPeople) {
    return StreamBuilder<QuerySnapshot>(
        stream: _userRef.where("uid", whereIn: likesPeople).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Row(
            children: [
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: snapshot.data!.size,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          backgroundImage:
                              NetworkImage(snapshot.data!.docs[index]["url"]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    print(likesPeople.runtimeType);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FavoriteUser(userId: likesPeople);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[50],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: _postingRef.doc(widget.postingId).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("");
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  post(snapshot.data),
                  //좋아요 -> 누른 사람얼굴
                  StreamBuilder<QuerySnapshot>(
                      stream: _postingRef
                          .doc(widget.postingId)
                          .collection('likes')
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> likes) {
                        if (!likes.hasData) {
                          return Center(child: Text(""));
                        }
                        if (likes.hasData && likes.data!.size > 0) {
                          List<dynamic> a = [];
                          for (int k = 0; k < likes.data!.size; k++) {
                            a.add(likes.data!.docs[k].id);
                          }

                          return Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white),
                              child: likesUser(a));
                        }
                        return Container();
                      }),
                  //댓글 리스트

                  snapshot.data!['replyCount'] == 0
                      ? Container(
                          height: 0,
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: _postingRef
                              .doc(widget.postingId)
                              .collection('review')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> reviewList) {
                            if (!reviewList.hasData) {
                              return Container();
                            }
                            return review(snapshot.data!['replyCount'],
                                reviewList.data!.docs.reversed.toList());
                          }),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            );
          }),
      bottomSheet: bottom(size),
    );
  }
}
