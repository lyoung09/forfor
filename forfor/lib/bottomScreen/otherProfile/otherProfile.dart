import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

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

  Widget bottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.orange[50]),
      child: InkWell(
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

  Widget qna() {
    return Text("");
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
                                fontSize: 22.5, fontWeight: FontWeight.w600)),
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

    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading"));
            }

            return DefaultTabController(
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
                    new Text("Address"),
                  ],
                ),
              ),
            );
          }),
      bottomSheet: bottom(),
    );
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
