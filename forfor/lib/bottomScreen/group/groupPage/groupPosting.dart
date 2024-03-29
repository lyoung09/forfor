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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.menu),
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
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
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
                                  AssetImage(Img.get('photo_female_2.jpg')),
                              size: 55,
                            ),
                            Container(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Bsilico Eat",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.grey[900])),
                                Container(height: 5),
                                Text(
                                  "June 1, 2015",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[500]),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(height: 10),
                        Container(
                          child: Text(MyStrings.middle_lorem_ipsum,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700])),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 15),
                  Image.asset(
                    Img.get('image_7.jpg'),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      children: <Widget>[
                        Container(width: 5),
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.grey[700]),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.share, color: Colors.grey[700]),
                          onPressed: () {},
                        ),
                        Spacer(),
                        IconButton(
                          icon:
                              Icon(Icons.mode_comment, color: Colors.grey[700]),
                          onPressed: () {},
                        ),
                        Text("12",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.grey[700])),
                        Container(width: 15),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300], height: 0),
                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text("Sandra Adams",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 18,
                  //               color: Colors.grey[900])),
                  //       Container(height: 5),
                  //       Text(MyStrings.middle_lorem_ipsum,
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //               fontSize: 18, color: Colors.grey[700]))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            Container(height: 5),
          ],
        ),
      ),
    );
  }
}
