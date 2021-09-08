import 'package:flutter/material.dart';

import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:forfor/widget/stacked_widget.dart';
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
  int _pageIndex = 0;
  final urlImages = [
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  ];

  Widget buildExpandedBox({
    required List<Widget> children,
    required Color color,
  }) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      );

  Widget buildStackedImages({
    TextDirection direction = TextDirection.ltr,
  }) {
    final double size = 60;
    final double xShift = 25;

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

    return StackedWidgets(
      direction: direction,
      items: items,
      size: size,
      xShift: xShift,
    );
  }

  Widget buildImage(String urlImage) {
    final double borderSize = 5;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _ListView(urlImages) {
    return Container(
        height: 120,
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                "${urlImages}",
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios_new),
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
            Divider(
              thickness: 1,
            ),
            Container(
                height: 120,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("participants",
                                style: MyText.headline(context)!
                                    .copyWith(color: Colors.grey[900])),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "1300명",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 12))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        onTap: () {
                          widget.controller.setSelectedMenuPosition(3);
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        shrinkWrap: false,
                                        children: [
                                          buildExpandedBox(
                                              children: [buildStackedImages()],
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Divider(
              thickness: 1.2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                elevation: 5,
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
                      Container(
                        height: 5,
                        child: Divider(
                          thickness: 1.2,
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: EdgeInsets.all(12),
                        child: Text(
                            'ahbhahahahlahlkahbhahahahlahlkahbhahahahlahlkahbhahahahlahlkahbhahahahlahlk',
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                            style: MyText.subhead(context)!
                                .copyWith(color: Colors.grey[600])),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Card(
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
                      Row(
                        children: [
                          Text("famous",
                              style: MyText.headline(context)!
                                  .copyWith(color: Colors.grey[900])),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    width: 1,
                                    color: (Colors.grey[400])!,
                                  ),
                                ),
                                primary: Colors.white,
                                elevation: 1),
                            onPressed: () {
                              widget.controller.setSelectedMenuPosition(1);
                            },
                            child: Container(
                              child: Text(
                                "All",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 5,
                        child: Divider(
                          thickness: 1.2,
                          color: Colors.grey[400],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.controller.setSelectedMenuPosition(1);
                        },
                        child: Container(
                          height: 100,
                          child: _bestInformation(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bestInformation() {
    return PageView.builder(
      itemCount: 10,
      controller: PageController(viewportFraction: 0.7),
      onPageChanged: (int index) => setState(() => _pageIndex = index),
      itemBuilder: (_, i) {
        return Transform.scale(
            scale: i == _pageIndex ? 1 : 0.9,
            child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.only(left: 12, top: 12),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "abcdefighitehith gehighee abcdefighitehith gehigheeabcdefighitehith gehigheeabcdefighitehith gehigheeabcdefighitehith gehighee",
                    style: TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                )));
      },
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
