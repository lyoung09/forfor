import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/infomation/sayWrite.dart';
import 'package:forfor/widget/loading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyQuestion extends StatefulWidget {
  final String myId;
  final String myName;
  final String myCountry;
  final String myImage;

  const MyQuestion(
      {Key? key,
      required this.myId,
      required this.myName,
      required this.myCountry,
      required this.myImage})
      : super(key: key);

  @override
  _MyQuestionState createState() => _MyQuestionState();
}

class _MyQuestionState extends State<MyQuestion> {
  String _value = "my";
  String _ago(Timestamp t) {
    String x = timeago
        .format(t.toDate())
        .replaceAll("minutes", "분")
        .replaceAll("a minute", "1분")
        .replaceAll("a moment", "방금")
        .replaceAll("a day", "1일")
        .replaceAll("ago", "전")
        .replaceAll("about", "")
        .replaceAll("an hour", "한시간")
        .replaceAll("hours", "시간")
        .replaceAll("one year", "1년")
        .replaceAll("years", "년");

    return x;
  }

  writingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SayWriting(
            uid: widget.myId,
          );
        },
      ),
    );
  }

  check(posting, index, favorite) async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); //

    DocumentReference ref = FirebaseFirestore.instance
        .collection('posting')
        .doc(posting.data.docs[index].id);
    ref.collection('likes');

    if (favorite[index]) {
      ref.collection("likes").doc(widget.myId).set({
        "likeId": widget.myId,
        "likeDatetime": myDateTime,
        "postingId": posting.data!.docs[index].id
      });
      ref.update({
        "count": FieldValue.increment(1),
      });
      //.update({
      // "count": FieldValue.increment(1),
      // "likes": FieldValue.arrayUnion([
      //   {
      //     "likeId": controller.user!.uid,
      //     "likeDatetime": myDateTime,
      //   }
      // ])
      //});
    }
    if (!favorite[index]) {
      ref.collection('likes').doc(widget.myId).delete();
      ref.update({
        "count": FieldValue.increment(-1),
      });

      //     .update(
      //   {
      //     "count": FieldValue.increment(-1),
      //     'likes': FieldValue.arrayRemove([
      //       {
      //         "likeId": controller.user!.uid,
      //         "likeDatetime": date,
      //       }
      //     ])
      //   },
      // );
    } else {}
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('posting');
  share(story, userUrl) async {
    final url = Uri.parse(userUrl);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path], text: '${story}');
  }

  save(postingId, userId) async {
    ref.doc(postingId).update({
      "save": FieldValue.arrayRemove([userId])
    });
  }

  delete(postingId) async {
    ref.doc(postingId).delete();
  }

  sue() {
    print("not good qna");
  }

  void postingExtra(context, postingId, userId, story, userUrl) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 7.5),
                    Text('Share'),
                  ],
                ),
                onTap: () {
                  share(story, userUrl);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_forever),
                    SizedBox(width: 7.5),
                    Text(' delete'),
                  ],
                ),
                onTap: () {
                  save(postingId, widget.myId);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Center(
                    child: new Text('cancel',
                        style: TextStyle(color: Colors.red))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 25))
            ],
          );
        });
  }

  Widget favoriteCheck(posting, favorite, index) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posting')
            .doc(posting.data!.docs[index].id)
            .collection('likes')
            .doc(widget.myId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> likeUser) {
          if (!likeUser.hasData) {
            favorite[index] = false;
          }
          if (likeUser.hasData) {
            favorite[index] = likeUser.data!.exists;
          }

          return IconButton(
            iconSize: 17.5,
            icon: Icon(
              Icons.favorite,
              color:
                  favorite[index] == true ? Colors.red[400] : Colors.grey[300],
            ),
            onPressed: () {
              favorite[index] = !favorite[index];

              check(posting, index, favorite);
            },
          );
        });
  }

  CollectionReference _ref = FirebaseFirestore.instance.collection("posting");

  Widget my(posting, index, favorite, ago) {
    return Row(
      children: [
        Container(width: 5),

        Expanded(
          child: Bubble(
            showNip: true,
            padding: BubbleEdges.only(left: 5, bottom: 5, right: 5),
            alignment: Alignment.centerLeft,
            borderColor: Colors.black,
            borderWidth: 1.3,
            nip: BubbleNip.no,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage("${widget.myImage}")),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'icons/flags/png/${widget.myCountry}.png',
                                package: 'country_icons'),
                            backgroundColor: Colors.white,
                            radius: 8,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 5, right: 5),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('${widget.myName}',
                                //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.5,
                                    color: Colors.orange[400],
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "${ago[index]}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      '${posting.data!.docs[index]["story"]}',
                      style: TextStyle(fontSize: 14),
                      //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      favoriteCheck(posting, favorite, index),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          posting.data!.docs[index]["count"] == null ||
                                  posting.data!.docs[index]["count"] < 1
                              ? ""
                              : "${posting.data!.docs[index]["count"]} ",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        iconSize: 17.5,
                        icon: Icon(Icons.chat_bubble_outline_outlined),
                        onPressed: () async {
                          Get.to(() => SayReply(
                                postingId: posting.data!.docs[index].id,
                                userId: widget.myId,
                                authorId: posting.data!.docs[index]["authorId"],
                                time: ago[index]!,
                                replyCount: posting.data!.docs[index]
                                    ["replyCount"],
                                story: posting.data!.docs[index]["story"],
                              ));
                        },
                      ),
                      Text(
                        posting.data!.docs[index]["replyCount"] == null ||
                                posting.data!.docs[index]["replyCount"] < 1
                            ? ""
                            : "${posting.data!.docs[index]["replyCount"]} ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.more_vert, size: 17),
                            onPressed: () {
                              postingExtra(
                                  context,
                                  posting.data!.docs[index].id,
                                  widget.myId,
                                  posting.data!.docs[index]["story"],
                                  widget.myImage);
                            },
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(width: 5),
        // Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(left: 8.0),
        //       child: Stack(
        //         children: [
        //           Align(
        //             alignment: Alignment.topLeft,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.all(Radius.circular(10)),
        //               child: Container(
        //                   width: 85,
        //                   height: 85,
        //                   child: Image.network(
        //                     '${posting[index]["authorImage"]}',
        //                     fit: BoxFit.fitWidth,
        //                   )),
        //             ),
        //           ),
        //           Positioned(
        //             bottom: 0,
        //             right: -5,
        //             child: CircleAvatar(
        //               backgroundImage: AssetImage(
        //                   'icons/flags/png/${posting[index]["authorCountry"]}.png',
        //                   package: 'country_icons'),
        //               backgroundColor: Colors.white,
        //               radius: 15,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Question",
              style: TextStyle(color: Colors.black, fontSize: 32)),
          centerTitle: true,
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.edit),
                iconSize: 32,
                onPressed: writingPage),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _value == "my"
              ? _ref
                  .where("authorId", isEqualTo: widget.myId)
                  .orderBy('timestamp', descending: true)
                  .snapshots()
              : _ref.where("save", arrayContains: widget.myId).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> posting) {
            if (!posting.hasData) {
              return Container();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, bottom: 15),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: _value == "my"
                              ? Text("Question ${posting.data!.size}")
                              : Text("Save ${posting.data!.size}")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 15),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                              child: Container(
                                padding: EdgeInsets.all(7.5),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text('${_value}'),
                                      SizedBox(width: 5),
                                      _value == "my"
                                          ? Icon(Icons.arrow_drop_down_rounded)
                                          : Icon(Icons.arrow_drop_up_rounded)
                                    ],
                                  ),
                                ),
                              ),
                              enabled: true,
                              enableFeedback: true,
                              onSelected: (String value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Text("My"),
                                      value: "my",
                                    ),
                                    PopupMenuItem(
                                      child: Text("Save"),
                                      value: "save",
                                    )
                                  ])),
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: posting.data!.size,
                    itemBuilder: (context, index) {
                      Map<int, String> ago = new Map<int, String>();
                      ago[index] = _ago(posting.data!.docs[index]["timestamp"]);
                      Map<int, bool> favorite = new Map<int, bool>();
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 18,
                          right: 10,
                          left: 10,
                        ),
                        child: _value == "my"
                            ? my(posting, index, favorite, ago)
                            : StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where("uid",
                                        isEqualTo: posting.data!.docs[index]
                                            ["authorId"])
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (context, count) {
                                        return Row(
                                          children: [
                                            Container(width: 5),

                                            Expanded(
                                              child: Bubble(
                                                showNip: true,
                                                padding: BubbleEdges.only(
                                                    left: 5,
                                                    bottom: 5,
                                                    right: 5),
                                                alignment: Alignment.centerLeft,
                                                borderColor: Colors.black,
                                                borderWidth: 1.3,
                                                nip: BubbleNip.no,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          5.0),
                                                              child: CircleAvatar(
                                                                  radius: 25,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${snapshot.data!.docs[count]["url"]}")),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: 0,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'icons/flags/png/${snapshot.data!.docs[count]["country"]}.png',
                                                                        package:
                                                                            'country_icons'),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                radius: 8,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          flex: 8,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        10.0,
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                    '${snapshot.data!.docs[count]["nickname"]}',
                                                                    //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18.5,
                                                                        color: Colors.orange[
                                                                            400],
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0),
                                                          child: Text(
                                                            "${ago[index]}",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                top: 15),
                                                        child: Text(
                                                          '${posting.data!.docs[index]["story"]}',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
                                                          maxLines: 4,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      height: 30,
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Row(
                                                        children: [
                                                          favoriteCheck(posting,
                                                              favorite, index),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        10.0),
                                                            child: Text(
                                                              posting.data!.docs[index]
                                                                              [
                                                                              "count"] ==
                                                                          null ||
                                                                      posting.data!.docs[index]
                                                                              [
                                                                              "count"] <
                                                                          1
                                                                  ? ""
                                                                  : "${posting.data!.docs[index]["count"]} ",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          IconButton(
                                                            iconSize: 17.5,
                                                            icon: Icon(Icons
                                                                .chat_bubble_outline_outlined),
                                                            onPressed:
                                                                () async {
                                                              Get.to(
                                                                  () =>
                                                                      SayReply(
                                                                        postingId: posting
                                                                            .data!
                                                                            .docs[index]
                                                                            .id,
                                                                        userId:
                                                                            widget.myId,
                                                                        authorId: posting
                                                                            .data!
                                                                            .docs[index]["authorId"],
                                                                        time: ago[
                                                                            index]!,
                                                                        replyCount: posting
                                                                            .data!
                                                                            .docs[index]["replyCount"],
                                                                        story: posting
                                                                            .data!
                                                                            .docs[index]["story"],
                                                                      ));
                                                            },
                                                          ),
                                                          Text(
                                                            posting.data!.docs[index]
                                                                            [
                                                                            "replyCount"] ==
                                                                        null ||
                                                                    posting.data!.docs[index]
                                                                            [
                                                                            "replyCount"] <
                                                                        1
                                                                ? ""
                                                                : "${posting.data!.docs[index]["replyCount"]} ",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          Spacer(),
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    size: 17),
                                                                onPressed: () {
                                                                  postingExtra(
                                                                      context,
                                                                      posting
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .id,
                                                                      posting.data!
                                                                              .docs[index]
                                                                          [
                                                                          "authorId"],
                                                                      posting.data!
                                                                              .docs[index]
                                                                          [
                                                                          "story"],
                                                                      widget
                                                                          .myImage);
                                                                },
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 5),
                                            // Column(
                                            //   children: [
                                            //     Padding(
                                            //       padding: EdgeInsets.only(left: 8.0),
                                            //       child: Stack(
                                            //         children: [
                                            //           Align(
                                            //             alignment: Alignment.topLeft,
                                            //             child: ClipRRect(
                                            //               borderRadius: BorderRadius.all(Radius.circular(10)),
                                            //               child: Container(
                                            //                   width: 85,
                                            //                   height: 85,
                                            //                   child: Image.network(
                                            //                     '${posting[index]["authorImage"]}',
                                            //                     fit: BoxFit.fitWidth,
                                            //                   )),
                                            //             ),
                                            //           ),
                                            //           Positioned(
                                            //             bottom: 0,
                                            //             right: -5,
                                            //             child: CircleAvatar(
                                            //               backgroundImage: AssetImage(
                                            //                   'icons/flags/png/${posting[index]["authorCountry"]}.png',
                                            //                   package: 'country_icons'),
                                            //               backgroundColor: Colors.white,
                                            //               radius: 15,
                                            //             ),
                                            //           )
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        );
                                      });
                                }),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
