import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show pi;
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'gCategoryDetail.dart';
import 'gcategory_menu.dart';
import 'gcategory_menuscreen.dart';

class GroupCategoryMain extends StatefulWidget {
  const GroupCategoryMain({Key? key}) : super(key: key);

  @override
  _GroupCategoryMainState createState() => _GroupCategoryMainState();
}

class _GroupCategoryMainState extends State<GroupCategoryMain> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  late String title;
  @override
  void initState() {
    super.initState();
    title = "home";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SliderMenuContainer(
              appBarColor: Colors.white,
              key: _key,
              title: Text(""),
              sliderMenuOpenSize: 200,
              drawerIconSize: 32,
              slideDirection: SlideDirection.RIGHT_TO_LEFT,
              isDraggable: false,
              sliderMenu: GcategoryMenuWidget(
                onItemClick: (title) {
                  _key.currentState!.closeDrawer();
                  setState(() {
                    this.title = title;
                  });
                },
              ),
              sliderMain: GcategoryMenuScreen()),
        ),
      ),
    );
  }
}
