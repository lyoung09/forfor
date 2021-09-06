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
  bool filter = false;
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
          Container(
            child: Divider(
              color: Colors.black,
              thickness: 1.1,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20)),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(35)),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )),
              Padding(padding: EdgeInsets.only(top: 20)),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(35)),
                child: IconButton(
                  icon: Icon(Icons.filter_1_rounded),
                  onPressed: () {
                    setState(() {
                      filter = !filter;
                    });
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 20))
            ],
          ),
          filter == true
              ? Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: tabbar(),
                    scrollDirection: Axis.horizontal,
                  ),
                )
              : Container(
                  width: 0,
                  height: 0,
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
