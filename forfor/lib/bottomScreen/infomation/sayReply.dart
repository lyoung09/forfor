import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/bottomScreen/profile/my_profile.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class SayReply extends StatefulWidget {
  final String postingId;
  final String userId;
  final String authorId;
  final int count;
  final int replyCount;
  final String story;
  final String time;
  final bool favorite;
  final List likes;

  const SayReply(
      {Key? key,
      required this.postingId,
      required this.userId,
      required this.authorId,
      required this.count,
      required this.replyCount,
      required this.story,
      required this.favorite,
      required this.time,
      required this.likes})
      : super(key: key);

  @override
  _SayReplyState createState() => _SayReplyState();
}

class _SayReplyState extends State<SayReply> {
  late bool favoriteThis;
  late FocusNode myFocusNode;
  bool textExist = false;
  TextEditingController _reply = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  initState() {
    super.initState();

    favoriteThis = widget.favorite;
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

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

  reply() async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); //

    await FirebaseFirestore.instance
        .collection('posting')
        .doc(widget.postingId)
        .update({
      "replyCount": FieldValue.increment(1),
      "reply": FieldValue.arrayUnion([
        {
          "reply": _reply.text.trim(),
          "replyId": widget.userId,
          "datetime": myDateTime
        }
      ])
    });
    _reply.clear();
    myFocusNode.unfocus();
  }

  Widget bottom(size) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Container(
            width: size.width * 0.75,
            height: 50,
            child: TextFormField(
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
                  print(value);
                  return null;
                }
                return null;
              },
              focusNode: myFocusNode,
              decoration: InputDecoration(
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
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(post["authorId"])
            .snapshots(),
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
                    InkWell(
                      onTap: () {
                        widget.userId == snapshot.data!["uid"]
                            ? Get.to(() => BottomNavigation(index: 4))
                            : Get.to(() => OtherProfile(
                                  uid: post["authorId"],
                                  userName: snapshot.data!["nickname"],
                                  userImage: snapshot.data!["url"],
                                  country: snapshot.data!["country"],
                                  introduction: snapshot.data!["introduction"],
                                  address: snapshot.data!["address"],
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
                            stream: FirebaseFirestore.instance
                                .collection('category')
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
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.story,
                          // "abjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjlabjasklabjsklsadjlkdjlkljablbljalkadjl",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))),
                ),
                Padding(padding: EdgeInsets.all(9)),
                Divider(),
                Row(
                  children: [
                    IconButton(
                      iconSize: 15,
                      icon: Icon(
                        Icons.favorite,
                        color: favoriteThis == true
                            ? Colors.red[400]
                            : Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          favoriteThis = !favoriteThis;

                          if (favoriteThis) {
                            // if (!user.contains(controller.user!.uid))
                            FirebaseFirestore.instance
                                .collection('posting')
                                .doc('${widget.postingId}')
                                .update({
                              "count": FieldValue.increment(1),
                              "likes": FieldValue.arrayUnion([widget.userId])
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection('posting')
                                .doc('${widget.postingId}')
                                .update(
                              {
                                "count": FieldValue.increment(-1),
                                'likes': FieldValue.arrayRemove([widget.userId])
                              },
                            );
                          }
                        });
                      },
                    ),
                    Text(
                      post!["count"] == 0 || post!["count"] < 1
                          ? ""
                          : "${post!["count"]} ",
                      style: TextStyle(fontSize: 12),
                    ),
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

  Widget review(count, review) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          Map<int, String> ago = new Map<int, String>();
          ago[index] = _ago(review[index]["datetime"]);
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
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
                                  InkWell(
                                    onTap: () {
                                      widget.userId == review[index]["replyId"]
                                          ? Get.to(
                                              () => BottomNavigation(index: 4))
                                          : Get.to(() => OtherProfile(
                                                uid: review[index]["replyId"],
                                                userName:
                                                    users.data!.docs[userCount]
                                                        ["nickname"],
                                                userImage: users.data!
                                                    .docs[userCount]["url"],
                                                country: users.data!
                                                    .docs[userCount]["country"],
                                                introduction:
                                                    users.data!.docs[userCount]
                                                        ["introduction"],
                                                address: users.data!
                                                    .docs[userCount]["address"],
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
                                ],
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
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("uid", whereIn: likesPeople)
            .snapshots(),
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
                  onPressed: () {},
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
          stream: FirebaseFirestore.instance
              .collection('posting')
              .doc(widget.postingId)
              .snapshots(),
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
                  snapshot.data!['count'] == 0
                      ? Container(height: 0)
                      : Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: likesUser(snapshot.data!["likes"])),
                  //댓글 리스트

                  snapshot.data!['replyCount'] == 0
                      ? Container(
                          height: 0,
                        )
                      : review(snapshot.data!['replyCount'],
                          snapshot.data!["reply"].reversed.toList()),
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
