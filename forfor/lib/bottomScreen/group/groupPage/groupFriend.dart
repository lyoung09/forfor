import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/adapter/buddylistAdapter.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class GroupFriend extends StatefulWidget {
  final SimpleHiddenDrawerController controller;

  const GroupFriend({Key? key, required this.controller}) : super(key: key);

  @override
  _GroupFriendState createState() => _GroupFriendState();
}

class _GroupFriendState extends State<GroupFriend> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _selectC = false;
  initState() {
    super.initState();

    if (auth.currentUser != null) {
      print(auth.currentUser?.uid);
    }
  }

  kakao() async {
    print("kakao login");
  }

  late BuildContext context;
  void onItemClick(int index, People obj) {
    // MyToast.show(obj.name!, context, duration: MyToast.LENGTH_SHORT);
  }
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    this.context = context;
    List<People> items = Dummy.getPeopleData();
    items.addAll(Dummy.getPeopleData());
    items.addAll(Dummy.getPeopleData());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        actions: [
          IconButton(
              color: Colors.black, icon: Icon(Icons.search), onPressed: () {})
        ],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              widget.controller.toggle();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Divider(
                color: Colors.black,
                thickness: 1.1,
              ),
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: tabbar(),
                scrollDirection: Axis.horizontal,
              ),
            ),
            BuddyListAdapter(items, onItemClick).getView(),
          ],
        ),
      ),
    );
  }

  Widget tabbar() {
    return Row(children: [
      Container(width: 10),
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child:
              Text("참여자", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onTap: () {
          //delayShowingContent();
          setState(() {});
        },
      ),
      Container(width: 10),
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child:
              Text("주변", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onTap: () {
          //delayShowingContent();
          setState(() {});
        },
      ),
      Container(width: 10),
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child:
              Text("성별", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onTap: () {
          //delayShowingContent();
          setState(() {});
        },
      ),
      Container(width: 10),
      InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child:
              Text("new", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onTap: () {
          //delayShowingContent();
          setState(() {});
        },
      ),
      Container(width: 10),
    ]);
  }
}
