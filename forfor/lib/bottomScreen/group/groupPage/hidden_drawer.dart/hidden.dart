import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupFriend.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupHome.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupPosting.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:slide_drawer/slide_drawer.dart';

class HiddenMenuSelect extends StatelessWidget {
  const HiddenMenuSelect({Key? key}) : super(key: key);

  Widget appbarIcon(position) {
    switch (position) {
      case 0:
        return Text("");

      case 1:
        return IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit));

      case 2:
        return Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
            IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
          ],
        );

      case 3:
        return IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit));
      default:
        return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleHiddenDrawer(
        typeOpen: TypeOpen.FROM_RIGHT,
        menu: Menu(),
        screenSelectedBuilder: (position, controller) {
          Widget screenCurrent = GroupHome(title: "home");

          switch (position) {
            case 0:
              screenCurrent = GroupHome(title: "home");
              break;
            case 1:
              screenCurrent = GroupPosting();
              break;
            case 2:
              screenCurrent = GroupFriend();
              break;
            case 3:
              screenCurrent = GroupChatting();
              break;
          }

          return Scaffold(
            //backgroundColor: backgroundColorContent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              actions: [
                Spacer(),
                appbarIcon(position),
                IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      controller.toggle();
                    }),
              ],
            ),
            body: screenCurrent,
          );
        },
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late SimpleHiddenDrawerController controller;

  void dispose() {
    super.dispose();
    controller.close();
  }

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    controller.toggle();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.grey[400],
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          color: Colors.white70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(
                color: Colors.black,
                thickness: 1.8,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    controller.setSelectedMenuPosition(0);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text("Home", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.5,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    controller.setSelectedMenuPosition(1);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Icons.home, color: Colors.black),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text("timeline", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.5,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    controller.setSelectedMenuPosition(2);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Icons.home, color: Colors.black),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text("friend", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.5,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    controller.setSelectedMenuPosition(3);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Icons.home, color: Colors.black),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text("groupchat", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  _HiddenDrawerState createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> itens = [];
  late BuildContext _scaffoldCtx;

  @override
  void initState() {
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Home",
          baseStyle: TextStyle(color: Colors.grey[400], fontSize: 28.0),
          colorLineSelected: Colors.teal,
          selectedStyle: TextStyle(color: Colors.black),
        ),
        GroupHome(title: "home")));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "포스팅",
          baseStyle: TextStyle(color: Colors.grey[400], fontSize: 28.0),
          colorLineSelected: Colors.orange,
          selectedStyle: TextStyle(color: Colors.black),
        ),
        GroupPosting()));
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "친구",
          baseStyle: TextStyle(color: Colors.grey[400], fontSize: 28.0),
          colorLineSelected: Colors.orange,
          selectedStyle: TextStyle(color: Colors.black),
        ),
        GroupFriend()));
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "채팅",
          baseStyle: TextStyle(color: Colors.grey[400], fontSize: 28.0),
          colorLineSelected: Colors.orange,
          selectedStyle: TextStyle(color: Colors.black),
        ),
        GroupChatting()));

    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), () {
        Scaffold.of(_scaffoldCtx).openDrawer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldCtx = context;
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.transparent,
      backgroundColorAppBar: Colors.transparent,
      screens: itens,

      isTitleCentered: true,
      actionsAppBar: [
        IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
      leadingAppBar: Icon(
        Icons.more,
        color: Colors.black,
      ),
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    disableAppBarDefault: false,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      //    slidePercent: 80.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0,
      //        iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      styleAutoTittleName: TextStyle(color: Colors.black, fontSize: 30),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
      //backgroundMenu: DecorationImage(image: ExactAssetImage('assets/image/.jpg'),fit: BoxFit.cover),
    );
  }
}
