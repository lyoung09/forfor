import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/infomation/sayWrite.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert';

import 'infomationDetail/WritingPage.dart';

class SayScreen extends StatefulWidget {
  const SayScreen({Key? key}) : super(key: key);

  @override
  _SayScreenState createState() => _SayScreenState();
}

class _SayScreenState extends State<SayScreen> with TickerProviderStateMixin {
  bool isSwitched1 = true;
  bool expand1 = false;
  late AnimationController controller1;
  late Animation<double> animation1, animation1View;
  TextEditingController _filter = new TextEditingController();
  final controller = Get.put(AuthController());
  late String uName;
  late String uImageUrl;
  late String uCountry;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userData(controller.user!.uid);
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);

    controller1.addListener(() {
      setState(() {});
    });
  }

  userData(uid) async {
    DocumentSnapshot ds = await UserDatabase().getUserDs(uid);
    setState(() {
      uName = ds.get('nickname');
      uImageUrl = ds.get('url');
      uCountry = ds.get('country');
    });
    print(ds.get('nickname'));
    print(ds.get('url'));
  }

  Widget selectCategory() {
    return SizeTransition(
      sizeFactor: animation1View,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab1",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.lightGreen[500],
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          togglePanel1();
                        },
                      ),
                      Container(height: 5),
                      Text(
                        "FRIENDS",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab2",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.yellow[600],
                        child: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "GROUPS",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab3",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.purple[400],
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "NEARBY",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab4",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.blue[400],
                        child: Icon(
                          Icons.near_me,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "MOMENT",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab5",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.indigo[300],
                        child: Icon(
                          Icons.crop_original,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "ALBUMS",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab6",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.green[500],
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "LIKES",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab7",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.lightGreen[400],
                        child: Icon(
                          Icons.subject,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "ARTICLES",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "fab8",
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.orange[300],
                        child: Icon(
                          Icons.textsms,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Container(height: 5),
                      Text(
                        "REVIEWS",
                        style: MyText.caption(context)!
                            .copyWith(color: MyColors.grey_40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();

    super.dispose();
  }

  void togglePanel1() {
    if (!expand1) {
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  dd(uid) async {
    var d = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: uid)
        .snapshots();
    return d;
  }

  writingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SayWriting(
              uid: controller.user!.uid,
              username: uName,
              userImage: uImageUrl,
              userCountry: uCountry);
        },
      ),
    );
  }

  Widget exapnded() {
    return Row(
      children: [
        Spacer(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, left: 1, right: 1),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.9))),
                  child: Text("Expanded",
                      style: TextStyle(
                          color: Colors.grey[800], fontFamily: "GloryBold")),
                ),
              ),
              Padding(padding: EdgeInsets.all(2)),
              Transform.rotate(
                angle: animation1.value * math.pi / 180,
                child: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: () {
                    togglePanel1();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
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

  Future<DocumentSnapshot<Map<String, dynamic>>> tt(posting, index) async {
    var author = await FirebaseFirestore.instance
        .collection('users')
        .doc(posting[index]["authorId"])
        .get();

    return author;
  }

  Widget otherUserQnA(posting, index, favorite) {
    Map<int, String> ago = new Map<int, String>();
    ago[index] = _ago(posting[index]["timestamp"]);

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where("uid", whereIn: [posting[index]["authorId"]]).snapshots(),
        builder: (context, snapshot) {
          print('12345   ${snapshot.data!.size}');
          print(index);
          print(snapshot.data!.docs[index]["nickname"]);
          return Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 10),
            child: Row(
              children: [
                Container(width: 5),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        var author = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(posting[index]["authorId"])
                            .get();
                        Get.to(() => OtherProfile(
                              uid: posting[index]["authorId"],
                              userName: snapshot.data!.docs[index]["nickname"],
                              userImage: posting[index]["authorImage"],
                              country: posting[index]["authorCountry"],
                              introduction: author["introduction"],
                              address: posting[index]["address"],
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                    width: 85,
                                    height: 85,
                                    child: Image.network(
                                      '${posting[index]["authorImage"]}',
                                      fit: BoxFit.fitWidth,
                                    )),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: -5,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'icons/flags/png/${posting[index]["authorCountry"]}.png',
                                    package: 'country_icons'),
                                backgroundColor: Colors.white,
                                radius: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(width: 5),
                Expanded(
                  child: Bubble(
                    showNip: true,
                    padding: BubbleEdges.only(
                        left: 22, top: 10, bottom: 0, right: 22),
                    alignment: Alignment.centerLeft,
                    borderColor: Colors.black,
                    borderWidth: 1.3,
                    nip: BubbleNip.leftCenter,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('${posting[index]["author"]}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.orange[400],
                                        fontWeight: FontWeight.bold))),
                            Text(
                              "${ago[index]}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${posting[index]["story"]}',
                              //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Divider(
                          thickness: 0.7,
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 30,
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Text(" ${posting[index]["address"]}",
                                  style: TextStyle(fontSize: 13)),
                              Spacer(),
                              IconButton(
                                iconSize: 17.5,
                                icon: Icon(
                                  Icons.favorite,
                                  color: favorite[index] == true
                                      ? Colors.red[400]
                                      : Colors.grey[300],
                                ),
                                onPressed: () {
                                  setState(() {
                                    favorite[index] = !favorite[index];

                                    if (favorite[index]) {
                                      // if (!user.contains(controller.user!.uid))
                                      FirebaseFirestore.instance
                                          .collection('posting')
                                          .doc('${posting[index].id}')
                                          .update({
                                        "count": FieldValue.increment(1),
                                        "likes": FieldValue.arrayUnion(
                                            [controller.user!.uid])
                                      });
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('posting')
                                          .doc('${posting[index].id}')
                                          .update(
                                        {
                                          "count": FieldValue.increment(-1),
                                          'likes': FieldValue.arrayRemove(
                                              [controller.user!.uid])

                                          // "uid": FieldValue.delete(),
                                          // "userNickname": FieldValue.delete(),
                                          // "userImage": FieldValue.delete(),
                                          // "userCoutnry": FieldValue.delete()
                                        },
                                      );
                                    }
                                  });
                                },
                              ),
                              Text(
                                posting[index]["count"] == null ||
                                        posting[index]["count"] < 1
                                    ? ""
                                    : "${posting[index]["count"]} ",
                                style: TextStyle(fontSize: 12),
                              ),
                              IconButton(
                                iconSize: 17.5,
                                icon: Icon(Icons.chat_bubble_outline_outlined),
                                onPressed: () {
                                  Get.to(() => SayReply(
                                      postingId: posting[index].id,
                                      userId: controller.user!.uid,
                                      userName: uName,
                                      userImage: uImageUrl,
                                      userCountry: uCountry,
                                      author: posting[index]["author"],
                                      authorCountry: posting[index]
                                          ["authorCountry"],
                                      authorId: posting[index]["authorId"],
                                      authorImage: posting[index]
                                          ["authorImage"],
                                      count: posting[index]["count"],
                                      favorite: favorite[index],
                                      time: ago[index]!,
                                      replyCount: posting[index]["replyCount"],
                                      story: posting[index]["story"],
                                      likes: posting[index]["likes"]));
                                },
                              ),
                              Text(
                                posting[index]["replyCount"] == null ||
                                        posting[index]["replyCount"] < 1
                                    ? ""
                                    : "${posting[index]["replyCount"]} ",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  bool like = false;

  Widget myQnA(posting, index, favorite) {
    Map<int, String> ago = new Map<int, String>();
    ago[index] = _ago(posting[index]["timestamp"]);

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(posting[index]["authorId"])
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 18, right: 10),
            child: Row(
              children: [
                Container(width: 5),
                Expanded(
                  child: Bubble(
                    showNip: true,
                    padding: BubbleEdges.only(
                        left: 22, top: 10, bottom: 0, right: 22),
                    alignment: Alignment.centerLeft,
                    borderColor: Colors.black,
                    borderWidth: 1.3,
                    nip: BubbleNip.rightCenter,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('${snapshot.data!["nickname"]}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.orange[400],
                                        fontWeight: FontWeight.bold))),
                            Text(
                              "${ago[index]}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${posting[index]["story"]}',
                              //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Divider(
                          thickness: 0.7,
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 30,
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Text(" ${posting[index]["address"]}",
                                  style: TextStyle(fontSize: 13)),
                              Spacer(),
                              IconButton(
                                iconSize: 17.5,
                                icon: Icon(
                                  Icons.favorite,
                                  color: favorite[index] == true
                                      ? Colors.red[400]
                                      : Colors.grey[300],
                                ),
                                onPressed: () {
                                  setState(() {
                                    favorite[index] = !favorite[index];

                                    if (favorite[index]) {
                                      // if (!user.contains(controller.user!.uid))
                                      FirebaseFirestore.instance
                                          .collection('posting')
                                          .doc('${posting[index].id}')
                                          .update({
                                        "count": FieldValue.increment(1),
                                        "likes": FieldValue.arrayUnion(
                                            [controller.user!.uid])
                                      });
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('posting')
                                          .doc('${posting[index].id}')
                                          .update(
                                        {
                                          "count": FieldValue.increment(-1),
                                          'likes': FieldValue.arrayRemove(
                                              [controller.user!.uid])

                                          // "uid": FieldValue.delete(),
                                          // "userNickname": FieldValue.delete(),
                                          // "userImage": FieldValue.delete(),
                                          // "userCoutnry": FieldValue.delete()
                                        },
                                      );
                                    }
                                  });
                                },
                              ),
                              Text(
                                posting[index]["count"] == null ||
                                        posting[index]["count"] < 1
                                    ? ""
                                    : "${posting[index]["count"]} ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 4),
                                child: Divider(
                                  thickness: 0.2,
                                ),
                              ),
                              IconButton(
                                iconSize: 17.5,
                                icon: Icon(Icons.chat_bubble_outline_outlined),
                                onPressed: () {
                                  Get.to(() => SayReply(
                                      postingId: posting[index].id,
                                      userId: controller.user!.uid,
                                      userName: uName,
                                      userImage: uImageUrl,
                                      userCountry: uCountry,
                                      author: snapshot.data!["nickname"],
                                      authorCountry: posting[index]
                                          ["authorCountry"],
                                      authorId: snapshot.data!["uid"],
                                      authorImage: snapshot.data!["url"],
                                      count: posting[index]["count"],
                                      favorite: favorite[index],
                                      time: ago[index]!,
                                      replyCount: posting[index]["replyCount"],
                                      story: posting[index]["story"],
                                      likes: posting[index]["likes"]));
                                },
                              ),
                              Text(
                                posting[index]["replyCount"] == null ||
                                        posting[index]["replyCount"] < 1
                                    ? ""
                                    : "${posting[index]["replyCount"]} ",
                                style: TextStyle(fontSize: 12),
                              ),
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
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posting')
                .orderBy("timestamp", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading"));
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("QnA",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.black,
                        ),
                        iconSize: 25,
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: 25,
                          onPressed: writingPage),
                    ]),
                    Container(
                        child: Divider(
                      thickness: 1,
                      color: Colors.grey[800],
                    )),
                    exapnded(),
                    expand1 == true
                        ? selectCategory()
                        : Container(
                            height: 0,
                          ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        Map<int, bool> favorite = new Map<int, bool>();

                        List<dynamic> user =
                            snapshot.data!.docs[index]["likes"];

                        user.contains(controller.user!.uid)
                            ? favorite[index] = true
                            : favorite[index] = false;

                        return controller.user!.uid ==
                                snapshot.data!.docs[index]["authorId"]
                            ? myQnA(snapshot.data!.docs, index, favorite)
                            : otherUserQnA(
                                snapshot.data!.docs, index, favorite);
                      },
                    ),
                  ],
                ),
              );
            }));
  }
}

class User {
  final String uid;

  User(
    this.uid,
  );

  User.fromJson(Map<String, dynamic> json) : uid = json['uid'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
      };
}

// @override
// Widget build(BuildContext context) {
//   var size = MediaQuery.of(context).size;
//   return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//         child: Column(
//           children: <Widget>[
//             Padding(padding: EdgeInsets.only(top: 40)),
//             Row(children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Text("QnA",
//                     style: TextStyle(color: Colors.black, fontSize: 30)),
//               ),
//               Spacer(),
//               IconButton(
//                 icon: Icon(
//                   Icons.notifications_none,
//                   color: Colors.black,
//                 ),
//                 iconSize: 25,
//                 onPressed: () {},
//               ),
//               IconButton(
//                   icon: Icon(Icons.edit),
//                   iconSize: 25,
//                   onPressed: writingPage),
//             ]),
//             Container(
//                 child: Divider(
//               thickness: 1,
//               color: Colors.grey[800],
//             )),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   exapnded(),
//                   expand1 == true
//                       ? selectCategory()
//                       : Container(
//                           height: 0,
//                         ),
//                   Padding(padding: EdgeInsets.all(10)),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                     alignment: Alignment.center,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: CircleImage(
//                                 imageProvider: AssetImage(
//                                     'assets/image/photo_female_1.jpg'),
//                                 size: 45,
//                               ),
//                             ),
//                             Container(width: 5),
//                             Expanded(
//                               child: Bubble(
//                                 showNip: true,
//                                 padding: BubbleEdges.only(
//                                     left: 22, top: 22, bottom: 0, right: 22),
//                                 alignment: Alignment.centerLeft,
//                                 borderColor: Colors.black,
//                                 borderWidth: 1.3,
//                                 nip: BubbleNip.leftCenter,
//                                 margin: const BubbleEdges.all(4),
//                                 child: Column(
//                                   children: [
//                                     Wrap(
//                                       children: [
//                                         //               Container(
//                                         //                 decoration: BoxDecoration(
//                                         //                   border: Border.all(
//                                         //                       color: Colors.black),
//                                         //                   borderRadius:
//                                         //                       BorderRadius.circular(10),
//                                         //                 ),
//                                         //                 child: Center(
//                                         //                   child: ClipRect(
//                                         //                     child: Container(
//                                         //                       child: Align(
//                                         //                         alignment:
//                                         //                             Alignment.center,
//                                         //                         child: Image.file(
//                                         //   File(),
//                                         //   height: 50,
//                                         //   width: 50,
//                                         //   fit: BoxFit.contain,
//                                         // ),
//                                         //                       ),
//                                         //                     ),
//                                         //                   ),
//                                         //                 ),
//                                         //               )
//                                       ],
//                                     ),
//                                     Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           "What's the problem?What",
//                                           maxLines: 3,
//                                           overflow: TextOverflow.ellipsis,
//                                         )),
//                                     Padding(padding: EdgeInsets.only(top: 5)),
//                                     Container(
//                                       alignment: Alignment.topRight,
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "12분전",
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                           Spacer(),
//                                           IconButton(
//                                             iconSize: 12,
//                                             icon: Icon(Icons
//                                                 .favorite_border_outlined),
//                                             onPressed: () {},
//                                           ),
//                                           Text(
//                                             "12",
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                           Container(
//                                             padding:
//                                                 EdgeInsets.only(right: 4),
//                                             child: Divider(
//                                               thickness: 0.2,
//                                             ),
//                                           ),
//                                           IconButton(
//                                             iconSize: 12,
//                                             icon: Icon(
//                                                 Icons.reply_all_outlined),
//                                             onPressed: () {},
//                                           ),
//                                           Text(
//                                             "1",
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.topLeft,
//                                   nip: BubbleNip.rightCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "it's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my story ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "ghhggghghghthe problem?What's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "What's the problem?What's the problem?What's the problem?What's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CircleImage(
//                                   imageProvider: AssetImage(
//                                       'assets/image/photo_female_1.jpg'),
//                                   size: 45,
//                                 ),
//                               ),
//                               Container(width: 5),
//                               Expanded(
//                                 child: Bubble(
//                                   showNip: true,
//                                   padding: BubbleEdges.only(
//                                       left: 22,
//                                       top: 22,
//                                       bottom: 0,
//                                       right: 22),
//                                   borderColor: Colors.black,
//                                   borderWidth: 1.3,
//                                   alignment: Alignment.centerLeft,
//                                   nip: BubbleNip.leftCenter,
//                                   margin: const BubbleEdges.all(4),
//                                   child: Column(
//                                     children: [
//                                       Wrap(
//                                         children: [
//                                           //               Container(
//                                           //                 decoration: BoxDecoration(
//                                           //                   border: Border.all(
//                                           //                       color: Colors.black),
//                                           //                   borderRadius:
//                                           //                       BorderRadius.circular(10),
//                                           //                 ),
//                                           //                 child: Center(
//                                           //                   child: ClipRect(
//                                           //                     child: Container(
//                                           //                       child: Align(
//                                           //                         alignment:
//                                           //                             Alignment.center,
//                                           //                         child: Image.file(
//                                           //   File(),
//                                           //   height: 50,
//                                           //   width: 50,
//                                           //   fit: BoxFit.contain,
//                                           // ),
//                                           //                       ),
//                                           //                     ),
//                                           //                   ),
//                                           //                 ),
//                                           //               )
//                                         ],
//                                       ),
//                                       Text(
//                                         "s's the problem?What's the problem?What's the problem?What's the ",
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(top: 5)),
//                                       Container(
//                                         alignment: Alignment.topRight,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "12분전",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Spacer(),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(Icons
//                                                   .favorite_border_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "12",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   EdgeInsets.only(right: 4),
//                                               child: Divider(
//                                                 thickness: 0.2,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               iconSize: 12,
//                                               icon: Icon(
//                                                   Icons.reply_all_outlined),
//                                               onPressed: () {},
//                                             ),
//                                             Text(
//                                               "1",
//                                               style: TextStyle(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         ),
//       ));
// }
