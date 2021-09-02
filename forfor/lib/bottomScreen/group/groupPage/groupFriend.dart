import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/adapter/buddylistAdapter.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/widget/my_colors.dart';

class GroupFriend extends StatefulWidget {
  const GroupFriend({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    this.context = context;
    List<People> items = Dummy.getPeopleData();
    items.addAll(Dummy.getPeopleData());
    items.addAll(Dummy.getPeopleData());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text("친구",
                      style: TextStyle(color: Colors.black, fontSize: 25))),
              Padding(padding: EdgeInsets.only(top: 20)),
              Spacer(),
              Icon(Icons.search),
            ],
          ),
          Container(
            child: Divider(
              color: Colors.black,
              thickness: 1.1,
            ),
          ),
          SingleChildScrollView(
            child: tabbar(),
            scrollDirection: Axis.horizontal,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          BuddyListAdapter(items, onItemClick).getView(),
        ],
      ),
    );
  }

  Widget tabbar() {
    return Row(children: [
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("new", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
          setState(() {});
        },
      ),
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("주변", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
        },
      ),
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("성별", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
        },
      ),
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("온라인", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
        },
      ),
      Container(width: 10),
    ]);
  }
}
