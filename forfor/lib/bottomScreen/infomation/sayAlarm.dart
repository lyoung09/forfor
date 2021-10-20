import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class SayAlarm extends StatefulWidget {
  final String uid;
  const SayAlarm({Key? key, required this.uid}) : super(key: key);

  @override
  _SayAlarmState createState() => _SayAlarmState();
}

class _SayAlarmState extends State<SayAlarm> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget all() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posting")
            .where("authorId", isEqualTo: widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              //return Container();

              return StreamBuilder<QuerySnapshot>(
                  stream: snapshot.data!.docs[index]["likes"].length == 0
                      ? null
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where("uid",
                              whereIn: snapshot.data!.docs[index]["likes"])
                          .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> users) {
                    if (!users.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: users.data!.size,
                      itemBuilder: (context, count) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return OtherProfile(
                                          uid: users.data!.docs[count]["uid"],
                                          userName: users.data!.docs[count]
                                              ["nickname"],
                                          userImage: users.data!.docs[count]
                                              ["url"],
                                          introduction: users.data!.docs[count]
                                              ["introduction"],
                                          country: users.data!.docs[count]
                                              ["country"],
                                          address: users.data!.docs[count]
                                              ["address"]);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(
                                                    "${users.data!.docs[count]['url']}")),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 45,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'icons/flags/png/${users.data!.docs[count]['country']}.png',
                                                  package: 'country_icons'),
                                              backgroundColor: Colors.white,
                                              radius: 8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${users.data!.docs[count]['nickname']}',
                                              // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.5,
                                              ),
                                            ),
                                          )),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      ' ${snapshot.data!.docs[index]["story"]}',
                                                      // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  '를 좋아합니다',
                                                  // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  });
            },
          );
        });
  }

  Widget reply() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posting")
            .where("authorId", isEqualTo: widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              //return Container();

              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs[index]["replyCount"],
                itemBuilder: (context, count) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: snapshot.data!.docs[index]["replyCount"] == 0
                          ? null
                          : FirebaseFirestore.instance
                              .collection('users')
                              .where("uid",
                                  isEqualTo: snapshot.data!.docs[index]["reply"]
                                      [count]["replyId"])
                              // .orderBy(snapshot.data!.docs[index]["reply"]
                              //     [count]["datetime"])
                              .snapshots(),
                      builder: (context, replyUser) {
                        Map<int, String> ago = new Map<int, String>();
                        ago[index] = _ago(snapshot.data!.docs[index]["reply"]
                            [count]["datetime"]);
                        print(ago);
                        if (!replyUser.hasData) {
                          return Container();
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: replyUser.data!.size,
                            itemBuilder: (context, userC) {
                              return Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 5,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: ListTile(
                                      leading: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return OtherProfile(
                                                    uid: replyUser.data!
                                                        .docs[userC]["uid"],
                                                    userName: replyUser
                                                            .data!.docs[userC]
                                                        ["nickname"],
                                                    userImage: replyUser.data!
                                                        .docs[userC]["url"],
                                                    introduction: replyUser
                                                            .data!.docs[userC]
                                                        ["introduction"],
                                                    country: replyUser.data!
                                                        .docs[userC]["country"],
                                                    address: replyUser.data!
                                                        .docs[userC]["address"]);
                                              },
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                      "${replyUser.data!.docs[userC]['url']}")),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              left: 0,
                                              child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'icons/flags/png/${replyUser.data!.docs[userC]['country']}.png',
                                                    package: 'country_icons'),
                                                backgroundColor: Colors.white,
                                                radius: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          '${replyUser.data!.docs[userC]['nickname']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.5,
                                          ),
                                        ),
                                      ),
                                      subtitle: InkWell(
                                        onTap: () {
                                          Get.to(() => SayReply(
                                                postingId: snapshot
                                                    .data!.docs[index].id,
                                                userId: widget.uid,
                                                authorId: snapshot.data!
                                                    .docs[index]["authorId"],
                                                time: ago[index]!,
                                                replyCount: snapshot.data!
                                                    .docs[index]["replyCount"],
                                                story: snapshot
                                                    .data!.docs[index]["story"],
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!.docs[index]["reply"][count]["reply"]}",
                                              maxLines: 5,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.5,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${ago[index]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.5,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          Get.to(() => SayReply(
                                                postingId: snapshot
                                                    .data!.docs[index].id,
                                                userId: widget.uid,
                                                authorId: snapshot.data!
                                                    .docs[index]["authorId"],
                                                time: ago[index]!,
                                                replyCount: snapshot.data!
                                                    .docs[index]["replyCount"],
                                                story: snapshot
                                                    .data!.docs[index]["story"],
                                              ));
                                        },
                                        child: Container(
                                          width: 60,
                                          child: Wrap(
                                            children: [
                                              Center(
                                                child: Text(
                                                    // snapshot.data!.docs[index]["story"]
                                                    //             .length >
                                                    //         8
                                                    //     ? ' ${snapshot.data!.docs[index]["story"].substring(0, 8)}\n${snapshot.data!.docs[index]["story"].substring(8, 15)}'
                                                    //     :
                                                    ' ${snapshot.data!.docs[index]["story"]}',
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        fontSize: 13.5)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // child: Container(
                                  //   height:120
                                  //   ,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     children: [
                                  //       Padding(
                                  //         padding: EdgeInsets.all(10),
                                  //       ),
                                  //       Expanded(
                                  //         flex: 3,
                                  //         child: Stack(
                                  //           children: [
                                  //             Padding(
                                  //               padding: EdgeInsets.only(
                                  //                   left: 5.0),
                                  //               child: CircleAvatar(
                                  //                   radius: 30,
                                  //                   backgroundColor:
                                  //                       Colors.white,
                                  //                   backgroundImage: NetworkImage(
                                  //                       "${replyUser.data!.docs[userC]['url']}")),
                                  //             ),
                                  //             Positioned(
                                  //               bottom: 5,
                                  //               left: 0,
                                  //               child: CircleAvatar(
                                  //                 backgroundImage: AssetImage(
                                  //                     'icons/flags/png/${replyUser.data!.docs[userC]['country']}.png',
                                  //                     package:
                                  //                         'country_icons'),
                                  //                 backgroundColor:
                                  //                     Colors.white,
                                  //                 radius: 8,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //       Padding(
                                  //         padding: EdgeInsets.all(4),
                                  //       ),
                                  //       Expanded(
                                  //         flex: 7,
                                  //         child: Column(
                                  //           children: [
                                  //             Expanded(
                                  //               flex: 4,
                                  //               child: Align(
                                  //                 alignment:
                                  //                     Alignment.centerLeft,
                                  //                 child: Text(
                                  //                   '${replyUser.data!.docs[userC]['nickname']}',
                                  //                   // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                  //                   maxLines: 1,
                                  //                   overflow:
                                  //                       TextOverflow.fade,
                                  //                   style: TextStyle(
                                  //                     fontWeight:
                                  //                         FontWeight.w600,
                                  //                     fontSize: 18.5,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               flex: 7,
                                  //               child: Align(
                                  //                 alignment:
                                  //                     Alignment.topLeft,
                                  //                 child: Text(
                                  //                   "${snapshot.data!.docs[index]["reply"][count]["reply"]}",
                                  //                   maxLines: 3,
                                  //                   overflow:
                                  //                       TextOverflow.clip,
                                  //                   style: TextStyle(
                                  //                     fontWeight:
                                  //                         FontWeight.w400,
                                  //                     fontSize: 15.5,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             SizedBox(
                                  //               height: 8,
                                  //             ),
                                  //             Expanded(
                                  //               flex: 3,
                                  //               child: Align(
                                  //                 alignment:
                                  //                     Alignment.topLeft,
                                  //                 child: Text(
                                  //                   "${ago[index]}",
                                  //                   style: TextStyle(
                                  //                     fontWeight:
                                  //                         FontWeight.w400,
                                  //                     fontSize: 14.5,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //       Spacer(),
                                  //       Expanded(
                                  //         child:
                                  // Text(
                                  //             snapshot
                                  //                         .data!
                                  //                         .docs[index]
                                  //                             ["story"]
                                  //                         .length >
                                  //                     18
                                  //                 ? ' ${snapshot.data!.docs[index]["story"].substring(0, 17)}'
                                  //                 : ' ${snapshot.data!.docs[index]["story"]}',
                                  //             style:
                                  //                 TextStyle(fontSize: 13.5)),
                                  //         flex: 2,
                                  //       ),
                                  //       Padding(
                                  //         padding: EdgeInsets.all(5),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              );
                            });
                      });
                },
              );
            },
          );
        });
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

  Widget favorite() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posting")
            .where("authorId", isEqualTo: widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              //return Container();

              return StreamBuilder<QuerySnapshot>(
                  stream: snapshot.data!.docs[index]["count"] == 0
                      ? null
                      : FirebaseFirestore.instance
                          .collection('posting')
                          // .where("uid",
                          //     whereIn: snapshot.data!.docs[index]["likes"])
                          .doc(snapshot.data!.docs[index].id)
                          .collection('likes')
                          .orderBy("likeDatetime", descending: true)
                          .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> users) {
                    if (!users.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: users.data!.size,
                      itemBuilder: (context, count) {
                        Map<int, String> ago = new Map<int, String>();
                        ago[count] =
                            _ago(users.data!.docs[count]["likeDatetime"]);

                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('uid',
                                    isEqualTo: users.data!.docs[count].id)
                                .snapshots(),
                            builder: (context, userInfo) {
                              if (!userInfo.hasData) {
                                return Container();
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userInfo.data!.size,
                                  itemBuilder: (context, userInfoCount) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return OtherProfile(
                                                              uid: userInfo.data!.docs[userInfoCount]
                                                                  ["uid"],
                                                              userName: userInfo
                                                                      .data!
                                                                      .docs[userInfoCount]
                                                                  ["nickname"],
                                                              userImage: userInfo
                                                                      .data!
                                                                      .docs[userInfoCount]
                                                                  ["url"],
                                                              introduction: userInfo
                                                                      .data!
                                                                      .docs[userInfoCount][
                                                                  "introduction"],
                                                              country: userInfo
                                                                  .data!
                                                                  .docs[userInfoCount]["country"],
                                                              address: userInfo.data!.docs[userInfoCount]["address"]);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.0),
                                                        child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${userInfo.data!.docs[userInfoCount]['url']}")),
                                                      ),
                                                      Positioned(
                                                        bottom: 5,
                                                        left: 0,
                                                        child: CircleAvatar(
                                                          backgroundImage: AssetImage(
                                                              'icons/flags/png/${userInfo.data!.docs[userInfoCount]['country']}.png',
                                                              package:
                                                                  'country_icons'),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(4),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '${userInfo.data!.docs[userInfoCount]['nickname']}',
                                                          // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "님이 좋아합니다",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "${ago[count]}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() => SayReply(
                                                          postingId: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id,
                                                          userId: widget.uid,
                                                          authorId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["authorId"],
                                                          time: ago[count]!,
                                                          replyCount: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["replyCount"],
                                                          story: snapshot.data!
                                                                  .docs[index]
                                                              ["story"],
                                                        ));
                                                  },
                                                  child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                      ["story"]
                                                                  .length >
                                                              18
                                                          ? ' ${snapshot.data!.docs[index]["story"].substring(0, 17)}'
                                                          : ' ${snapshot.data!.docs[index]["story"]}',
                                                      style: TextStyle(
                                                          fontSize: 13.5)),
                                                ),
                                                flex: 2,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            });
                      },
                    );
                  });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text('QnA 알림',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              centerTitle: true,
              pinned: false,
              floating: false,
              bottom: TabBar(
                indicatorColor: Colors.black,
                isScrollable: true,
                tabs: [
                  // Tab(
                  //     child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.3,
                  //         child: Center(
                  //             child: Text('All',
                  //                 style: TextStyle(fontSize: 13.5))))),
                  Tab(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                              child: Text('favorite',
                                  style: TextStyle(fontSize: 13.5))))),
                  Tab(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                              child: Text('answer',
                                  style: TextStyle(fontSize: 13.5))))),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            //all(),
            favorite(),
            reply(),
          ],
        ),
      )),
    );
  }
//Assign here

}
