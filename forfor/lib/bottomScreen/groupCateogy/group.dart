import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forfor/adapter/listselectionAdapter.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';

import 'package:get/get.dart';

class SideSheetBasicRoute extends StatefulWidget {
  SideSheetBasicRoute();

  @override
  SideSheetBasicRouteState createState() => new SideSheetBasicRouteState();
}

class SideSheetBasicRouteState extends State<SideSheetBasicRoute> {
  late BuildContext _scaffoldCtx;
  TextStyle textStyle =
      TextStyle(color: Colors.pink[300], height: 1.4, fontSize: 16);
  TextStyle labelStyle = TextStyle(color: Colors.pink[300]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink[300]!, width: 1));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink[300]!, width: 2));

  double value1 = 0.3;
  void setValue1(double value) => setState(() => value1 = value);
  final TextEditingController _filter = new TextEditingController();

  void onItemClick(int index, People obj) {
    //MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          brightness: Brightness.dark,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: MyColors.grey_60),
          //leading: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          title: TextField(
              controller: _filter,
              decoration: new InputDecoration(hintText: 'Search...')),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: () {
                  Scaffold.of(_scaffoldCtx).openEndDrawer();
                }),
          ]),
      body: Builder(builder: (BuildContext context) {
        _scaffoldCtx = context;
        return Container(
          margin: const EdgeInsets.all(20),
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemBuilder: (builder, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/dummy/image_4.jpg',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Phasellus a Turpis id Nisi",
                              style: TextStyle(
                                  fontSize: 24, color: Colors.grey[800]),
                            ),
                            Container(height: 10),
                            Container(
                              child: Text(MyStrings.middle_lorem_ipsum,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[700])),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.transparent),
                            child: Text(
                              "SHARE",
                              style: TextStyle(color: MyColors.accent),
                            ),
                            onPressed: () {},
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.transparent),
                            child: Text(
                              "EXPLORE",
                              style: TextStyle(color: MyColors.accent),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Container(height: 5)
                    ],
                  ),
                );
              },
              separatorBuilder: (builder, index) {
                return Divider(
                  height: 10,
                  thickness: 0,
                );
              },
              itemCount: 20),
        );
      }),
      endDrawer: Container(
        width: 200,
        child: Drawer(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // CircleAvatar(
                  //   radius: 65,
                  //   backgroundColor: Colors.grey,
                  //   child: CircleAvatar(
                  //     radius: 60,
                  //     backgroundImage: AssetImage('assets/images/user_profile.jpg'),
                  //   ),
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   'Nick',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 30,
                  //       fontFamily: 'BalsamiqSans'),
                  //),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      Text("category1")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ////sliderItem('Category1', Icons.category),
                  SizedBox(
                    height: 20,
                  ),
                  //sliderItem('Category2', Icons.notifications_active),
                  SizedBox(
                    height: 20,
                  ),
                  //sliderItem('Category3', Icons.favorite),
                  SizedBox(
                    height: 20,
                  ),
                  //sliderItem('Search', Icons.settings),
                  SizedBox(
                    height: 20,
                  ),
                  //sliderItem('adding group', Icons.add_circle),
                  SizedBox(
                    height: 20,
                  ),
                  //sliderItem('fileter\nLike,posting', Icons.arrow_back_ios)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
