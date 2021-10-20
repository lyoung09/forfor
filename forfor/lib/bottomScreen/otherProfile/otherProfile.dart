import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/profile/my_update.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class OtherProfile extends StatefulWidget {
  final String uid;
  final String userName;
  final String userImage;
  final String country;
  final String address;

  final String introduction;
  const OtherProfile(
      {Key? key,
      required this.uid,
      required this.userImage,
      required this.userName,
      required this.introduction,
      required this.country,
      required this.address})
      : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  late ScrollController scrollController;
  final controller = Get.put(AuthController());
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  Widget _buildtitle() {
    Widget profile = new Container(
      height: 30.0,
      width: 200.0,
      child: Text("${widget.userName}",
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: TextStyle(color: Colors.black)),
    );

    double scale;
    if (scrollController.hasClients) {
      scale = scrollController.offset / 500;

      scale = scale * 2;
      if (scale > 1) {
        scale = 1.0;
      }
    } else {
      scale = 0.0;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: profile,
    );
  }

  Widget bottom(snapshot) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.orange[50]),
      child: controller.user!.uid == widget.uid
          ? Text("")
          // InkWell(
          //     onTap: () {
          //       Get.to(() => UserUpdate(
          //           category: snapshot.data!["category"],
          //           image: widget.userImage,
          //           nickname: widget.userName,
          //           introduction: widget.introduction,
          //           uid: controller.user!.uid));
          //     },
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Spacer(),
          //         // InkWell(
          //         //     onTap: () {},
          //         //     child: Column(
          //         //       children: [
          //         //         Image.asset(
          //         //           'assets/icon/buddy.png',
          //         //           width: 35,
          //         //           height: 30,
          //         //         ),
          //         //         Text("buddy", style: TextStyle(fontSize: 20)),
          //         //       ],
          //         //     )),

          //         Text(
          //           "My Group",
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         Padding(padding: EdgeInsets.only(left: 20)),

          //         SvgPicture.asset(
          //           "assets/svg/profileBottom.svg",
          //           fit: BoxFit.fill,
          //           width: 35,
          //           height: 33,
          //         ),
          //         Spacer(),
          //         //Iconutton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
          //       ],
          //     ),
          //   )
          : InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  // InkWell(
                  //     onTap: () {},
                  //     child: Column(
                  //       children: [
                  //         Image.asset(
                  //           'assets/icon/buddy.png',
                  //           width: 35,
                  //           height: 30,
                  //         ),
                  //         Text("buddy", style: TextStyle(fontSize: 20)),
                  //       ],
                  //     )),

                  Text(
                    "ADD",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Image.asset(
                    'assets/icon/buddy.png',
                    width: 35,
                    height: 33,
                  ),
                  Spacer(),
                  //Iconutton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
                ],
              ),
            ),
    );
  }

  Widget group(snapshot) {
    final List<int> category = snapshot.data!["category"].cast<int>();

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('categoryId', whereIn: [
          for (int i = 0; i < snapshot.data!["category"].length; i++)
            category[i]
        ]).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> categorySnapshot) {
          if (!categorySnapshot.hasData) {
            return Text("");
          }

          return SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categorySnapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 20),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "${categorySnapshot.data!.docs[index]['categoryImage']}")),
                          ),
                          Text(
                            categorySnapshot.data!.docs[index]["categoryName"],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }

  check(posting, index, favorite) async {
    print(posting.data!.docs[index].id);

    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); //

    DocumentReference ref = FirebaseFirestore.instance
        .collection('posting')
        .doc(posting.data!.docs[index].id);
    ref.collection('likes');

    if (favorite[index]) {
      print("helo");
      ref.collection("likes").doc(controller.user!.uid).set({
        "likeId": controller.user!.uid,
        "likeDatetime": myDateTime,
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
      ref.collection('likes').doc(controller.user!.uid).delete();
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

  String _ago(Timestamp t) {
    String x = timeago
        .format(t.toDate())
        .replaceAll("minutes", "분")
        .replaceAll("a minute", "1분")
        .replaceAll("a day", "1일")
        .replaceAll("a moment", "방금")
        .replaceAll("ago", "전")
        .replaceAll("about", "")
        .replaceAll("an hour", "한시간")
        .replaceAll("hours", "시간")
        .replaceAll("one year", "1년")
        .replaceAll("years", "년");

    return x;
  }

  Widget q() {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posting")
            .where("authorId", isEqualTo: controller.user!.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> posting) {
          if (!posting.hasData) {
            return Container();
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: posting.data!.size,
              itemBuilder: (context, index) {
                Map<int, String> ago = new Map<int, String>();
                ago[index] = _ago(posting.data!.docs[index]["timestamp"]);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18, left: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${widget.userName}',
                                            //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.orange[400],
                                                fontWeight: FontWeight.bold))),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${posting.data!.docs[index]["story"]}',
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
                                    Text(
                                      "${ago[index]}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                    Text(
                                        " ${posting.data!.docs[index]["address"]}",
                                        style: TextStyle(fontSize: 13)),
                                    Spacer(),
                                    IconButton(
                                      iconSize: 17.5,
                                      icon: Icon(
                                          Icons.chat_bubble_outline_outlined),
                                      onPressed: () {
                                        Get.to(() => SayReply(
                                              postingId:
                                                  posting.data!.docs[index].id,
                                              userId: controller.user!.uid,
                                              authorId: posting.data!
                                                  .docs[index]["authorId"],
                                              time: ago[index]!,
                                              replyCount: posting.data!
                                                  .docs[index]["replyCount"],
                                              story: posting.data!.docs[index]
                                                  ["story"],
                                            ));
                                      },
                                    ),
                                    Text(
                                      posting.data!.docs[index]["replyCount"] ==
                                                  null ||
                                              posting.data!.docs[index]
                                                      ["replyCount"] <
                                                  1
                                          ? ""
                                          : "${posting.data!.docs[index]["replyCount"]} ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget a() {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posting")
            .where("authorId", isEqualTo: widget.uid)
            //.orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> posting) {
          if (!posting.hasData) {
            return Container();
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: posting.data!.size,
              itemBuilder: (context, index) {
                Map<int, String> ago = new Map<int, String>();
                ago[index] = _ago(posting.data!.docs[index]["timestamp"]);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18, left: 10),
                  child: Row(
                    children: [
                      Container(width: 5),
                      Column(
                        children: [
                          Padding(
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
                                          '${widget.userImage}',
                                          fit: BoxFit.fitWidth,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -5,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'icons/flags/png/${widget.country}.png',
                                        package: 'country_icons'),
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                  ),
                                )
                              ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${widget.userName}',
                                            //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.orange[400],
                                                fontWeight: FontWeight.bold))),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${posting.data!.docs[index]["story"]}',
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
                                    Text(
                                      "${ago[index]}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                    Text(
                                        " ${posting.data!.docs[index]["address"]}",
                                        style: TextStyle(fontSize: 13)),
                                    Spacer(),
                                    IconButton(
                                      iconSize: 17.5,
                                      icon: Icon(
                                          Icons.chat_bubble_outline_outlined),
                                      onPressed: () {
                                        Get.to(() => SayReply(
                                              postingId:
                                                  posting.data!.docs[index].id,
                                              userId: controller.user!.uid,
                                              authorId: posting.data!
                                                  .docs[index]["authorId"],
                                              time: ago[index]!,
                                              replyCount: posting.data!
                                                  .docs[index]["replyCount"],
                                              story: posting.data!.docs[index]
                                                  ["story"],
                                            ));
                                      },
                                    ),
                                    Text(
                                      posting.data!.docs[index]["replyCount"] ==
                                                  null ||
                                              posting.data!.docs[index]
                                                      ["replyCount"] <
                                                  1
                                          ? ""
                                          : "${posting.data!.docs[index]["replyCount"]} ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = new SliverAppBar(
      backgroundColor: Colors.orange[50],
      expandedHeight: 300.0,
      pinned: true,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 22,
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: _buildtitle(),
          background: Container(
            //decoration: BoxDecoration(color: Colors.orange[50]),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(widget.userImage),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'icons/flags/png/${widget.country}.png',
                              package: 'country_icons'),
                          backgroundColor: Colors.white,
                          radius: 15,
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                  )),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(widget.userName,
                            //"1widget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userNamewidget.userName",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(widget.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                  Spacer()
                ]),
                SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Text(widget.introduction,
                            // "write yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourself",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style:
                                //userModel.introduction == null

                                //  ?
                                TextStyle(color: Colors.black, fontSize: 12)
                            // : MyText.subhead(context)!
                            //     .copyWith(
                            //         color: Colors.grey[900])
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text(""));
          }
          return Scaffold(
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    flexibleSpaceWidget,
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          indicatorColor: Colors.black87,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.black26,
                          tabs: [
                            Tab(
                                icon: Image.asset(
                                  "assets/icon/group.png",
                                  fit: BoxFit.fill,
                                  width: 25,
                                  height: 25,
                                ),
                                text: "Group"),
                            Tab(
                                icon: Image.asset(
                                  "assets/icon/qa.png",
                                  fit: BoxFit.fill,
                                  width: 25,
                                  height: 25,
                                ),
                                text: "QnA"),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: new TabBarView(
                  children: <Widget>[
                    group(snapshot),
                    controller.user!.uid == widget.uid ? q() : a(),
                  ],
                ),
              ),
            ),
            bottomSheet:
                controller.user!.uid == widget.uid ? null : bottom(snapshot),
          );
        });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(color: Colors.orange[50]),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
