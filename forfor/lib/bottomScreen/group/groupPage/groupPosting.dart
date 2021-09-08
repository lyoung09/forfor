import 'package:flutter/material.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'dart:math' as math;

import 'groupWriting.dart';

class GroupPosting extends StatefulWidget {
  final SimpleHiddenDrawerController controller;
  const GroupPosting({Key? key, required this.controller}) : super(key: key);

  @override
  _GroupPostingState createState() => _GroupPostingState();
}

class _GroupPostingState extends State<GroupPosting>
    with TickerProviderStateMixin {
  bool isSwitched1 = true;
  bool expand1 = false;
  late AnimationController controller1;
  late Animation<double> animation1, animation1View;
  TextEditingController _filter = new TextEditingController();
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
          return GroupWriting();
        },
      ),
    );
  }

  List list = [
    "Flutter",
    "Angular",
    "Node js",
  ];

  Widget customTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                side: BorderSide(
                  width: 1,
                  color: (Colors.grey[400])!,
                ),
              ),
            ),
          ),
          onPressed: () {},
          child: Text("All", style: TextStyle(color: Colors.black)),
        ),
        Padding(padding: EdgeInsets.only(right: 15)),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                side: BorderSide(
                  width: 1,
                  color: (Colors.grey[400])!,
                ),
              ),
            ),
          ),
          onPressed: () {},
          child: Text("1H", style: TextStyle(color: Colors.black)),
        ),
        Padding(padding: EdgeInsets.only(right: 15)),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                side: BorderSide(
                  width: 1,
                  color: (Colors.grey[400])!,
                ),
              ),
            ),
          ),
          onPressed: () {},
          child: Text("1D", style: TextStyle(color: Colors.black)),
        ),
        Padding(padding: EdgeInsets.only(right: 15)),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                side: BorderSide(
                  width: 1,
                  color: (Colors.grey[400])!,
                ),
              ),
            ),
          ),
          onPressed: () {},
          child: Text("1W", style: TextStyle(color: Colors.black)),
        ),
        Padding(padding: EdgeInsets.only(right: 15)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              widget.controller.toggle();
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.black,
            onPressed: writingPage,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            customTab(),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
                child: Divider(
              thickness: 1,
              color: Colors.grey[800],
            )),
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AssetImage(Img.get('photo_female_1.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              imageProvider:
                                  AssetImage(Img.get('photo_female_6.jpg')),
                              size: 40,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}
