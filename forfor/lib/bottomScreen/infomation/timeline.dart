import 'package:flutter/material.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'dart:math' as math;

import 'infomationDetail/WritingPage.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> with TickerProviderStateMixin {
  bool isSwitched1 = true;
  bool expand1 = false;
  late AnimationController controller1;
  late Animation<double> animation1, animation1View;

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

  writingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return WritingPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
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
                                  fontSize: 20, color: Colors.grey[800]),
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
                            Container(width: 5, height: 0),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: writingPage,
                            ),
                          ],
                        ),
                      ),
                      expand1 == true
                          ? SizeTransition(
                              sizeFactor: animation1View,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: Colors.white,
                                elevation: 2,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              FloatingActionButton(
                                                heroTag: "fab1",
                                                elevation: 0,
                                                mini: true,
                                                backgroundColor:
                                                    Colors.lightGreen[500],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.yellow[600],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.purple[400],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.blue[400],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              FloatingActionButton(
                                                heroTag: "fab5",
                                                elevation: 0,
                                                mini: true,
                                                backgroundColor:
                                                    Colors.indigo[300],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.green[500],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.lightGreen[400],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                                                backgroundColor:
                                                    Colors.orange[300],
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
                                                    .copyWith(
                                                        color:
                                                            MyColors.grey_40),
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
                            )
                          : Container(
                              height: 0,
                            ),
                    ],
                  ),
                  preferredSize: Size.fromHeight(0)),
            ),
            SliverFillRemaining(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1)),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleImage(
                                    imageProvider: AssetImage(
                                        Img.get('photo_female_1.jpg')),
                                    size: 40,
                                  ),
                                  Container(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Emma Richmond",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey[800])),
                                      Container(height: 2),
                                      Row(
                                        children: <Widget>[
                                          Text("in",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[500])),
                                          Container(width: 3),
                                          Text("Hwy, Carthage",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(height: 10),
                              Container(
                                child: Text(MyStrings.middle_lorem_ipsum,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[500])),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        Divider(color: Colors.grey[300], height: 0),
                        Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(width: 5),
                              IconButton(
                                icon: Icon(Icons.thumb_up,
                                    color: Colors.green[200], size: 25),
                                onPressed: () {},
                              ),
                              Text("12 likes",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              IconButton(
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.lightBlue[400], size: 25),
                                onPressed: () {},
                              ),
                              Text("4 comments",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              Spacer(),
                              Text("3h ago",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[500])),
                              Container(width: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1)),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleImage(
                                    imageProvider:
                                        AssetImage(Img.get('photo_male_7.jpg')),
                                    size: 40,
                                  ),
                                  Container(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Homer J. Allen",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey[800])),
                                      Container(height: 2),
                                      Row(
                                        children: <Widget>[
                                          Text("in",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[500])),
                                          Container(width: 3),
                                          Text("City, Office",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(height: 10),
                              Container(
                                child: Text(MyStrings.short_lorem_ipsum,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[500])),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        Image.asset(
                          Img.get('image_2.jpg'),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Divider(color: Colors.grey[300], height: 0),
                        Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(width: 5),
                              IconButton(
                                icon: Icon(Icons.thumb_up,
                                    color: Colors.green[200], size: 25),
                                onPressed: () {},
                              ),
                              Text("145 likes",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              IconButton(
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.lightBlue[400], size: 25),
                                onPressed: () {},
                              ),
                              Text("12 comments",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              Spacer(),
                              Text("12h ago",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[500])),
                              Container(width: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1)),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleImage(
                                    imageProvider: AssetImage(
                                        Img.get('photo_female_6.jpg')),
                                    size: 40,
                                  ),
                                  Container(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Lillie Hoyos",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey[800])),
                                      Container(height: 2),
                                      Row(
                                        children: <Widget>[
                                          Text("in",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[500])),
                                          Container(width: 3),
                                          Text("Easthampton, MA",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(height: 10),
                              Container(
                                child: Text(MyStrings.lorem_ipsum,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[500])),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        Divider(color: Colors.grey[300], height: 0),
                        Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(width: 5),
                              IconButton(
                                icon: Icon(Icons.thumb_up,
                                    color: Colors.green[200], size: 25),
                                onPressed: () {},
                              ),
                              Text("1k likes",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              IconButton(
                                icon: Icon(Icons.chat_bubble,
                                    color: Colors.lightBlue[400], size: 25),
                                onPressed: () {},
                              ),
                              Text("1.3k comments",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500])),
                              Spacer(),
                              Text("12h ago",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[500])),
                              Container(width: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ]),
    );
  }
}
