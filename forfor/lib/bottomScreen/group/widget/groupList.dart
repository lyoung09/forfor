import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/group/groupPage/hidden_drawer.dart/hidden.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../group_click.dart';

class GroupList extends StatefulWidget {
  GroupList();

  @override
  GroupListState createState() => new GroupListState();
}

class GroupListState extends State<GroupList> with TickerProviderStateMixin {
  bool expand = true;
  late AnimationController controller;
  late Animation<double> animation, animationView;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    animation = Tween(begin: 0.0, end: -0.5).animate(controller);
    animationView = CurvedAnimation(parent: controller, curve: Curves.linear);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), () {
        togglePanel();
      });
    });

    super.initState();
  }

  groupScreen() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return HiddenMenuSelect();
    //     },
    //   ),
    // );
    Navigator.pushNamed(context, '/groupPage');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 35, left: 25, right: 25),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          "120명",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert, size: 15),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/image/photo_female_1.jpg",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Group name",
                                style: MyText.headline(context)!.copyWith(
                                    color: MyColors.grey_90,
                                    fontWeight: FontWeight.w500)),
                            RotationTransition(
                              turns: animation,
                              child: IconButton(
                                icon: Icon(Icons.expand_more),
                                onPressed: () {
                                  togglePanel();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizeTransition(
                          sizeFactor: animationView,
                          child: Container(
                              height: 130,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        "our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~our group is studying korean~",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: MyText.subhead(context)!
                                            .copyWith(
                                                color: MyColors.grey_60,
                                                fontWeight: FontWeight.w500)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            primary: Colors.white,
                                            elevation: 2),
                                        onPressed: groupScreen,
                                        child: Text(
                                          "참여하기",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void togglePanel() {
    if (!expand) {
      controller.forward(from: 0);
    } else {
      controller.reverse();
    }
    expand = !expand;
  }
}
