import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupFriend.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupHome.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupPosting.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/widget/stacked_widget.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:slide_drawer/slide_drawer.dart';

import '../groupSearch.dart';

class JosKeys {
  static final groupHome = GlobalKey();
  static final groupFriend = GlobalKey();
  static final groupChat = GlobalKey();
  static final groupSear = GlobalKey();
  static final groupPost = GlobalKey();
}

class Hey extends StatefulWidget {
  const Hey({Key? key}) : super(key: key);

  @override
  _HeyState createState() => _HeyState();
}

class _HeyState extends State<Hey> {
  late SimpleHiddenDrawerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _controller.toggle();
        return Future(() => false);
      },
      child: MaterialApp(
        home: SimpleHiddenDrawer(
          menu: Menu(),
          screenSelectedBuilder: (position, controller) {
            _controller = controller;
            Widget screenCurrent = GroupHome(controller: _controller);
            switch (position) {
              case 0:
                screenCurrent =
                    GroupHome(controller: _controller, key: JosKeys.groupHome);
                break;
              case 1:
                screenCurrent = GroupPosting(
                    controller: _controller, key: JosKeys.groupPost);
                break;
              case 2:
                screenCurrent = GroupChatting(
                    controller: _controller, key: JosKeys.groupChat);
                break;
              case 3:
                screenCurrent = GroupFriend(
                    controller: _controller, key: JosKeys.groupFriend);
                break;
              case 4:
                screenCurrent = GroupSearch(
                    controller: _controller, key: JosKeys.groupSear);
                break;
              case 5:
                screenCurrent = GroupFriend(controller: _controller);
                break;
            }

            return Scaffold(
              body: screenCurrent,
            );
          },
        ),
      ),
    );
  }
}

class HiddenMenuSelect extends StatelessWidget {
  HiddenMenuSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late SimpleHiddenDrawerController _controller;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: MaterialApp(
        home: SimpleHiddenDrawer(
          menu: Menu(),
          screenSelectedBuilder: (position, controller) {
            _controller = controller;
            Widget screenCurrent = GroupHome(controller: _controller);
            switch (position) {
              case 0:
                screenCurrent =
                    GroupHome(controller: _controller, key: JosKeys.groupHome);
                break;
              case 1:
                screenCurrent = GroupPosting(
                    controller: _controller, key: JosKeys.groupPost);
                break;
              case 2:
                screenCurrent = GroupChatting(
                    controller: _controller, key: JosKeys.groupChat);
                break;
              case 3:
                screenCurrent = GroupFriend(
                    controller: _controller, key: JosKeys.groupFriend);
                break;
              case 4:
                screenCurrent = GroupSearch(
                    controller: _controller, key: JosKeys.groupSear);
                break;
              case 5:
                screenCurrent = GroupFriend(controller: _controller);
                break;
            }

            return Scaffold(
              body: screenCurrent,
            );
          },
        ),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late SimpleHiddenDrawerController controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void setState(fn) {
    super.setState(fn);
    if (mounted) {
      controller.dispose();
      _animationController.dispose();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = SimpleHiddenDrawerController.of(context);
    controller.toggle();

    controller.addListener(() {
      if (controller.state == MenuState.open) {
        _animationController.forward();
      }

      if (controller.state == MenuState.closing) {
        _animationController.reverse();
      }
    });
  }

  backHomePage() async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return BottomNavigation();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 60,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        //  controller.setSelectedMenuPosition(0);
                      },
                      child: Text(
                        "join",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 90),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        //  controller.setSelectedMenuPosition(0);
                      },
                      child: Text(
                        "1300명",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 250,
                height: 150,

                //padding: EdgeInsets.only(left: 15),

                child: Image.asset('assets/image/photo_female_1.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  onPressed: () {
                    //  controller.setSelectedMenuPosition(0);
                  },
                  child: Text(
                    "group namegroup namegroup namegroup namegroup namegroup namegroup namegroup namegroup namegroup namegroup name",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25)),
            // GridView.count(
            //   crossAxisCount: 5,
            //   children: List.generate(5, (index) {
            //     return CircleAvatar(
            //       child: Image.asset('assets/image/photo_female_1.jpg'),
            //     );
            //   }),
            // ),

            FadeTransition(
              opacity: _animationController,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(0);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("Home",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(1);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("timeline",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(2);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.chat_sharp,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("chat",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(3);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("friends",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(4);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("search",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        width: 200.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                          onPressed: () {
                            controller.setSelectedMenuPosition(5);
                          },
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Icon(
                                Icons.ac_unit,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text("anyting",
                                  style: TextStyle(color: Colors.black)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            padding: EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 60,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                onPressed: backHomePage,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
