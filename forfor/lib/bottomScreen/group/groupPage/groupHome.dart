import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:forfor/widget/star_rating.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

import 'groupPosting.dart';

class GroupHome extends StatefulWidget {
  final SimpleHiddenDrawerController controller;
  const GroupHome({Key? key, required this.controller}) : super(key: key);

  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  int page = 0;
  static const int MAX = 3;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.menu),
            onPressed: () {
              widget.controller.toggle();
            }),
        actions: [
          Icon(
            Icons.ac_unit,
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 45)),
            Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.all(0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  width: width * 0.9,
                  child: Stack(
                    children: <Widget>[
                      PageView(
                        children: <Widget>[
                          // Hero(
                          //     tag: 'grupImage',
                          //     child:
                          Image.asset('assets/image/photo_female_1.jpg',
                              fit: BoxFit.cover),
                          //),
                          Image.asset(Img.get('image_shop_10.jpg'),
                              fit: BoxFit.cover),
                          Image.asset(Img.get('image_shop_11.jpg'),
                              fit: BoxFit.cover),
                        ],
                        onPageChanged: onPageViewChange,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.5)
                              ])),
                          child: Align(
                            alignment: Alignment.center,
                            child: buildDots(context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("group name",
                      style: TextStyle(color: Colors.black, fontSize: 32)),
                )),
            Padding(padding: EdgeInsets.only(top: 20)),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("introuduciton",
                        style: MyText.headline(context)!
                            .copyWith(color: Colors.grey[900])),
                    Container(height: 5),
                    Text('ahbhahahahlahlk',
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: MyText.subhead(context)!
                            .copyWith(color: Colors.grey[600])),
                    Container(height: 20),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("notice",
                        style: MyText.headline(context)!
                            .copyWith(color: Colors.grey[900])),
                    Container(height: 5),
                    Text(MyStrings.long_lorem_ipsum,
                        textAlign: TextAlign.justify,
                        style: MyText.subhead(context)!
                            .copyWith(color: Colors.grey[600])),
                    Container(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    setState(() {});
  }

  Widget buildDots(BuildContext context) {
    Widget widget;

    List<Widget> dots = [];
    for (int i = 0; i < MAX; i++) {
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? Colors.blue : Colors.grey[100],
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
