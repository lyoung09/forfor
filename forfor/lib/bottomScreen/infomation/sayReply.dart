import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class SayReply extends StatefulWidget {
  final String postingId;
  final String userId;
  final String userName;
  final String userImage;
  final String userCountry;
  final String author;
  final String authorCountry;
  final String authorId;
  final String authorImage;
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
      required this.userName,
      required this.userImage,
      required this.userCountry,
      required this.author,
      required this.authorCountry,
      required this.authorId,
      required this.authorImage,
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
          "replyName": widget.userName,
          "replyCountry": widget.userCountry,
          "replyImage": widget.userImage,
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
                onTap: () async {
                  var author = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(post["authorId"])
                      .get();

                  Get.to(() => OtherProfile(
                        uid: post["authorId"],
                        userName: post["author"],
                        userImage: post["authorImage"],
                        country: post["authorCountry"],
                        introduction: author["introduction"],
                        address: author["address"],
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
                                NetworkImage("${widget.authorImage}")),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 5,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'icons/flags/png/${widget.authorCountry}.png',
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
                children: [
                  Text(widget.author,
                      style: TextStyle(
                          color: Colors.orange[400],
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  Text(widget.author),
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
          ),
          Padding(padding: EdgeInsets.all(9)),
          Divider(),
          Row(
            children: [
              IconButton(
                iconSize: 15,
                icon: Icon(
                  Icons.favorite,
                  color:
                      favoriteThis == true ? Colors.red[400] : Colors.grey[300],
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
  }

  Widget review(count, review) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          Map<int, String> ago = new Map<int, String>();
          ago[index] = _ago(review[index]["datetime"]);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
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
                        onTap: () async {
                          var author = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(review[index]["replyId"])
                              .get();

                          Get.to(() => OtherProfile(
                                uid: review[index]["replyId"],
                                userName: review[index]["replyName"],
                                userImage: review[index]["replyImage"],
                                country: review[index]["replyCountry"],
                                introduction: author["introduction"],
                                address: author["address"],
                              ));
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "${review[index]["replyImage"]}")),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 5,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'icons/flags/png/${review[index]["replyCountry"]}.png',
                                    package: 'country_icons'),
                                backgroundColor: Colors.white,
                                radius: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(review[index]["replyName"],
                            style: TextStyle(fontSize: 16.5)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      review[index]["reply"],
                      //"helelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelel",

                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, right: 16),
                  child: Text("${ago[index]}", style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
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
                  Container(
                    child: Row(
                      children: [],
                    ),
                  ),
                  //댓글 리스트
                  Divider(),
                  snapshot.data!['replyCount'] == 0
                      ? Container(
                          height: 0,
                        )
                      : review(
                          snapshot.data!['replyCount'], snapshot.data!["reply"])
                  // : ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: BouncingScrollPhysics(),
                  //     itemCount: snapshot.data!['replyCount'],
                  //     itemBuilder: (BuildContext context, int index) {
                  //       if (index == 0) {
                  //         return Container();
                  //       }
                  //       Map<int, String> ago = new Map<int, String>();
                  //       ago[index] = _ago(
                  //           snapshot.data!["reply"][index]["datetime"]);
                  //       return Card(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(5.0),
                  //               child: Column(
                  //                 children: [
                  //                   Padding(
                  //                       padding: EdgeInsets.only(top: 8)),
                  //                   Stack(
                  //                     children: [
                  //                       Padding(
                  //                         padding:
                  //                             EdgeInsets.only(left: 15.0),
                  //                         child: CircleAvatar(
                  //                             radius: 25,
                  //                             backgroundColor: Colors.white,
                  //                             backgroundImage: NetworkImage(
                  //                                 "${snapshot.data!["reply"][index]["replyImage"]}")),
                  //                       ),
                  //                       Positioned(
                  //                         bottom: 0,
                  //                         left: 5,
                  //                         child: CircleAvatar(
                  //                           backgroundImage: AssetImage(
                  //                               'icons/flags/png/${snapshot.data!["reply"][index]["replyCountry"]}.png',
                  //                               package: 'country_icons'),
                  //                           backgroundColor: Colors.white,
                  //                           radius: 8,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.only(left: 15.0),
                  //                     child: Text(
                  //                         snapshot.data!["reply"][index]
                  //                             ["replyName"],
                  //                         style: TextStyle(fontSize: 16.5)),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Expanded(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Text(
                  //                   snapshot.data!["reply"][index]["reply"],
                  //                   //"helelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelelhelelelellelelel",

                  //                   style: TextStyle(fontSize: 14),
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   EdgeInsets.only(top: 15.0, right: 16),
                  //               child: Text("${ago[index]}"),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }),
                  ,
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
