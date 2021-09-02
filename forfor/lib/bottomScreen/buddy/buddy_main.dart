import 'package:flutter/material.dart';
import 'package:forfor/adapter/invitePeopleAdater.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';

class InvitePeopleScreen extends StatefulWidget {
  InvitePeopleScreen();

  @override
  InvitePeopleScreenState createState() => new InvitePeopleScreenState();
}

class InvitePeopleScreenState extends State<InvitePeopleScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;
  bool finishLoading = true;
  final TextEditingController inputController = new TextEditingController();

  void onItemClick(int index, String obj) {
    //MyToast.show(obj, context, duration: MyToast.LENGTH_SHORT);
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<People> items = Dummy.getPeopleData();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              brightness: Brightness.dark,
              elevation: 0,
              flexibleSpace: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.fromLTRB(8, 32, 8, 0),
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.grey[600],
                      highlightColor: Colors.grey[600],
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.search, color: Colors.grey[500])),
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        controller: inputController,
                        style: TextStyle(color: Colors.grey[600], fontSize: 18),
                        keyboardType: TextInputType.text,
                        onSubmitted: (term) {
                          setState(() {
                            finishLoading = false;
                          });
                          //delayShowingContent();
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search People & Places',
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: MyColors.grey_40),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.mic, color: Colors.grey[500]),
                        onPressed: () {
                          inputController.clear();
                          setState(() {});
                        }),
                    IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.grey[500]),
                        onPressed: () {
                          setState(() {});
                        }),
                  ],
                ),
              ),
              pinned: true,
              floating: false,
              backgroundColor: MyColors.primary,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                labelStyle:
                    MyText.body1(context)!.copyWith(color: Colors.white),
                unselectedLabelColor: Colors.grey[200],
                tabs: [
                  Tab(text: "K-pop"),
                  Tab(text: "language"),
                  Tab(text: "living"),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: InvitePeople(items, onItemClick).getView(),
      ),
    );
  }
}
