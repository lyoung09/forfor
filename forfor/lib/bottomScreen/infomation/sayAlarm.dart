import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';

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
                      stream: snapshot.data!.docs[index]["replyCount"] < 1
                          ? null
                          : FirebaseFirestore.instance
                              .collection('users')
                              .where("uid",
                                  isEqualTo: snapshot.data!.docs[index]["reply"]
                                      [count]["replyId"])
                              .snapshots(),
                      builder: (context, replyUser) {
                        if (!replyUser.hasData) {
                          return Container();
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: replyUser.data!.size,
                            itemBuilder: (context, userC) {
                              return Container(
                                  child: Column(
                                children: [
                                  Text(snapshot.data!.docs[index]["reply"]
                                      [count]["reply"]),
                                  Text(
                                      '${replyUser.data!.docs[userC]["nickname"]}'),
                                ],
                              ));
                            });
                        // return ListView.builder(
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, replyCount) {
                        //       return StreamBuilder<QuerySnapshot>(
                        //           stream: FirebaseFirestore.instance
                        //               .collection('users')
                        //               .where("uid",
                        //                   isEqualTo: replyUser.data!
                        //                       .docs[replyCount]["replyId"])
                        //               .snapshots(),
                        //           builder: (context,
                        //               AsyncSnapshot<QuerySnapshot> users) {
                        //             if (!users.hasData) {
                        //               return Container();
                        //             }
                        //             return Column(
                        //               children: [
                        //                 InkWell(
                        //                   onTap: () {
                        //                     Navigator.of(context).push(
                        //                       MaterialPageRoute(
                        //                         builder:
                        //                             (BuildContext context) {
                        //                           return OtherProfile(
                        //                               uid: replyUser.data!.docs[replyCount]
                        //                                   ["uid"],
                        //                               userName: replyUser.data!
                        //                                       .docs[replyCount]
                        //                                   ["nickname"],
                        //                               userImage: replyUser.data!
                        //                                       .docs[replyCount]
                        //                                   ["url"],
                        //                               introduction: replyUser
                        //                                       .data!
                        //                                       .docs[replyCount]
                        //                                   ["introduction"],
                        //                               country: replyUser.data!.docs[replyCount]
                        //                                   ["country"],
                        //                               address: replyUser.data!
                        //                                   .docs[replyCount]["address"]);
                        //                         },
                        //                       ),
                        //                     );
                        //                   },
                        //                   child: Container(
                        //                     height: 90,
                        //                     width: MediaQuery.of(context)
                        //                         .size
                        //                         .width,
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.start,
                        //                       children: [
                        //                         Padding(
                        //                           padding: EdgeInsets.all(10),
                        //                         ),
                        //                         Expanded(
                        //                           flex: 2,
                        //                           child: Stack(
                        //                             children: [
                        //                               Padding(
                        //                                 padding:
                        //                                     EdgeInsets.only(
                        //                                         left: 5.0),
                        //                                 child: CircleAvatar(
                        //                                     radius: 25,
                        //                                     backgroundColor:
                        //                                         Colors.white,
                        //                                     backgroundImage:
                        //                                         NetworkImage(
                        //                                             "${replyUser.data!.docs[replyCount]['url']}")),
                        //                               ),
                        //                               Positioned(
                        //                                 bottom: 5,
                        //                                 right: 45,
                        //                                 child: CircleAvatar(
                        //                                   backgroundImage: AssetImage(
                        //                                       'icons/flags/png/${replyUser.data!.docs[replyCount]['country']}.png',
                        //                                       package:
                        //                                           'country_icons'),
                        //                                   backgroundColor:
                        //                                       Colors.white,
                        //                                   radius: 8,
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         Padding(
                        //                           padding: EdgeInsets.all(4),
                        //                         ),
                        //                         Expanded(
                        //                           flex: 8,
                        //                           child: Column(
                        //                             children: [
                        //                               Expanded(
                        //                                   child: Align(
                        //                                 alignment: Alignment
                        //                                     .centerLeft,
                        //                                 child: Text(
                        //                                   '${replyUser.data!.docs[replyCount]['nickname']}',
                        //                                   // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                        //                                   maxLines: 1,
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis,
                        //                                   style: TextStyle(
                        //                                     fontWeight:
                        //                                         FontWeight.w600,
                        //                                     fontSize: 15.5,
                        //                                   ),
                        //                                 ),
                        //                               )),
                        //                               Row(
                        //                                 children: [
                        //                                   Expanded(
                        //                                     flex: 8,
                        //                                     child: Align(
                        //                                       alignment:
                        //                                           Alignment
                        //                                               .topLeft,
                        //                                       child: Padding(
                        //                                         padding:
                        //                                             const EdgeInsets
                        //                                                 .all(8),
                        //                                         child: Text(
                        //                                           ' ${replyUser.data!.docs[replyCount]["reply"]}',
                        //                                           // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                        //                                           maxLines: 3,
                        //                                           overflow:
                        //                                               TextOverflow
                        //                                                   .ellipsis,
                        //                                           style:
                        //                                               TextStyle(
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                             fontSize:
                        //                                                 12,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   Expanded(
                        //                                     flex: 4,
                        //                                     child: Text(
                        //                                       '를 좋아합니다',
                        //                                       // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                        //                                       maxLines: 1,
                        //                                       overflow:
                        //                                           TextOverflow
                        //                                               .ellipsis,
                        //                                       style: TextStyle(
                        //                                         fontWeight:
                        //                                             FontWeight
                        //                                                 .w500,
                        //                                         fontSize: 12,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         Padding(
                        //                           padding: EdgeInsets.all(10),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             );
                        //           });
                        //     });
                      });
                },
              );
            },
          );
        });
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
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
              title: Text('QnA 알람',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              centerTitle: true,
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Text('All')),
                  Tab(child: Text('Favorite')),
                  Tab(child: Text('Comment')),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            all(),
            favorite(),
            reply(),
          ],
        ),
      )),
    );
  }
//Assign here

}
