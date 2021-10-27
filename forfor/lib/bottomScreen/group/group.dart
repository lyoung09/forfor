import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/model/userLocation.dart';
import 'package:get/get.dart';

import 'package:forfor/data/user.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:provider/provider.dart';

import 'addGroup.dart';
import 'addGroupStepper.dart';
import 'group_click.dart';
import 'widget/groupList.dart';

class Group extends StatefulWidget {
  String? uid;
  Group({this.uid});
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> with TickerProviderStateMixin {
  bool isSwitched1 = true;
  bool expand1 = false;
  late AnimationController controller1;
  late Animation<double> animation1, animation1View;
  late BuildContext _scaffoldCtx;
  TextEditingController _filter = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);
    print(auth.currentUser!.uid);

    controller1.addListener(() {
      setState(() {});
    });
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

  addGroup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StepperGroupAdd();
        },
      ),
    );
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

  Widget stackCategory() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        Container(
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
      ],
    );
  }

  String _value = "최신";
  bool settingGroup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Builder(builder: (BuildContext context) {
        _scaffoldCtx = context;
        return CustomScrollView(
            physics: ScrollPhysics(parent: PageScrollPhysics()),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: expand1 == true ? 300 : 50,
                brightness: Brightness.dark,
                floating: false,
                pinned: true,
                backgroundColor: Colors.grey[100],
                flexibleSpace: FlexibleSpaceBar(),
                bottom: PreferredSize(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(width: 15, height: 0),
                              Text(
                                "K-pop",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[800],
                                    fontFamily: "GloryBold"),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey[100]),
                                child: Transform.rotate(
                                  angle: animation1.value * math.pi / 180,
                                  child: IconButton(
                                    icon: Icon(Icons.expand_more),
                                    onPressed: () {
                                      togglePanel1();
                                    },
                                  ),
                                ),
                              ),
                              Spacer(flex: 1),
                              IconButton(
                                icon: Icon(
                                  Icons.notifications_none,
                                  color: Colors.black,
                                ),
                                onPressed: addGroup,
                                iconSize: 20,
                              ),
                              Container(width: 5, height: 0),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: Colors.black,
                                ),
                                onPressed: addGroup,
                                iconSize: 20,
                              ),
                              PopupMenuButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    side: BorderSide(color: Colors.black)),
                                iconSize: 20,
                                color: Colors.white,
                                elevation: 20,
                                enabled: true,
                                enableFeedback: true,
                                onSelected: (String value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("최신",
                                        style: TextStyle(
                                            fontWeight: _value == "최신"
                                                ? FontWeight.bold
                                                : null)),
                                    value: "최신",
                                  ),
                                  PopupMenuItem(
                                    child: Text("인기",
                                        style: TextStyle(
                                            fontWeight: _value == "인기"
                                                ? FontWeight.bold
                                                : null)),
                                    value: "인기",
                                  ),
                                  PopupMenuItem(
                                    child: Text("오픈",
                                        style: TextStyle(
                                            fontWeight: _value == "오픈"
                                                ? FontWeight.bold
                                                : null)),
                                    value: "오픈",
                                  ),
                                  PopupMenuItem(
                                    child: Text("적은",
                                        style: TextStyle(
                                            fontWeight: _value == "적은"
                                                ? FontWeight.bold
                                                : null)),
                                    value: "적은",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        expand1 == true
                            ? selectCategory()
                            : Container(
                                height: 0,
                              ),
                      ],
                    ),
                    preferredSize: Size.fromHeight(0)),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 15),
                          height: 150,
                          child: stackCategory()),
                      PreferredSize(
                        preferredSize: Size.fromHeight(25),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          alignment: Alignment.bottomCenter,
                          constraints: BoxConstraints.expand(height: 80),
                          child: Card(
                            color: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.search,
                                        color: Colors.grey[600]),
                                    onPressed: () {
                                      _filter.clear();
                                      setState(() {});
                                    }),
                                Expanded(
                                  child: TextField(
                                    maxLines: 1,
                                    controller: _filter,
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 18),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '${_value}',
                                      hintStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemBuilder: (builder, index) {
                            return GroupList();
                          },
                          separatorBuilder: (builder, index) {
                            return Divider(
                              height: 1,
                              thickness: 0,
                            );
                          },
                          itemCount: 20),
                    ],
                  ),
                ),
              )
            ]);
      }),
      // endDrawer: Container(
      //   width: 200,
      //   child: Drawer(
      //     child: SingleChildScrollView(
      //       padding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
      //       child: Container(
      //         color: Colors.grey[100],
      //         padding: const EdgeInsets.only(top: 30),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //             Align(
      //                 alignment: Alignment.topLeft,
      //                 child: IconButton(
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                     icon: Icon(Icons.exit_to_app))),
      //             // SizedBox(
      //             //   height: 30,
      //             // ),
      //             // CircleAvatar(
      //             //   radius: 65,
      //             //   backgroundColor: Colors.grey,
      //             //   child: CircleAvatar(
      //             //     radius: 60,
      //             //     backgroundImage: AssetImage('assets/images/user_profile.jpg'),
      //             //   ),
      //             // ),
      //             Row(
      //               children: [
      //                 IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      //                 Text("category1")
      //               ],
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Wrap(
      //               children: [
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Icon(
      //                     Icons.ac_unit,
      //                     size: 40,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),

      //             Container(
      //               child: Divider(
      //                 thickness: 2.5,
      //                 color: Colors.black,
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             //sliderItem('Category2', Icons.notifications_active),

      //             //sliderItem('fileter\nLike,posting', Icons.arrow_back_ios)
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
