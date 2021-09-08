import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/sayWrite.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'dart:math' as math;

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
          return SayWriting();
        },
      ),
    );
  }

  List list = [
    "Flutter",
    "Angular",
    "Node js",
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text("Say",
                      style: TextStyle(color: Colors.black, fontSize: 30)),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CircleImage(
                                  imageProvider: AssetImage(
                                      'assets/image/photo_female_1.jpg'),
                                  size: 45,
                                ),
                              ),
                              Container(width: 5),
                              Expanded(
                                child: Bubble(
                                  showNip: true,
                                  padding: BubbleEdges.all(22),
                                  alignment: Alignment.centerLeft,
                                  borderColor: Colors.black,
                                  borderWidth: 1.3,
                                  nip: BubbleNip.leftCenter,
                                  margin: const BubbleEdges.all(4),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        children: [
                                          //               Container(
                                          //                 decoration: BoxDecoration(
                                          //                   border: Border.all(
                                          //                       color: Colors.black),
                                          //                   borderRadius:
                                          //                       BorderRadius.circular(10),
                                          //                 ),
                                          //                 child: Center(
                                          //                   child: ClipRect(
                                          //                     child: Container(
                                          //                       child: Align(
                                          //                         alignment:
                                          //                             Alignment.center,
                                          //                         child: Image.file(
                                          //   File(),
                                          //   height: 50,
                                          //   width: 50,
                                          //   fit: BoxFit.contain,
                                          // ),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               )
                                        ],
                                      ),
                                      Text(
                                        "What's the problem?What",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.topLeft,
                                    nip: BubbleNip.rightCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "it's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my storyit's my story ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "ghhggghghghthe problem?What's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "What's the problem?What's the problem?What's the problem?What's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    padding: BubbleEdges.all(22),
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleImage(
                                    imageProvider: AssetImage(
                                        'assets/image/photo_female_1.jpg'),
                                    size: 45,
                                  ),
                                ),
                                Container(width: 5),
                                Expanded(
                                  child: Bubble(
                                    showNip: true,
                                    padding: BubbleEdges.all(22),
                                    borderColor: Colors.black,
                                    borderWidth: 1.3,
                                    alignment: Alignment.centerLeft,
                                    nip: BubbleNip.leftCenter,
                                    margin: const BubbleEdges.all(4),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            //               Container(
                                            //                 decoration: BoxDecoration(
                                            //                   border: Border.all(
                                            //                       color: Colors.black),
                                            //                   borderRadius:
                                            //                       BorderRadius.circular(10),
                                            //                 ),
                                            //                 child: Center(
                                            //                   child: ClipRect(
                                            //                     child: Container(
                                            //                       child: Align(
                                            //                         alignment:
                                            //                             Alignment.center,
                                            //                         child: Image.file(
                                            //   File(),
                                            //   height: 50,
                                            //   width: 50,
                                            //   fit: BoxFit.contain,
                                            // ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               )
                                          ],
                                        ),
                                        Text(
                                          "s's the problem?What's the problem?What's the problem?What's the ",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
