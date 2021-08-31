import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/adapter/buddylistAdapter.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/service/authService.dart';
import 'package:forfor/widget/my_colors.dart';

class BuddyMainScreen extends StatefulWidget {
  const BuddyMainScreen({Key? key}) : super(key: key);

  @override
  _BuddyMainScreenState createState() => _BuddyMainScreenState();
}

class _BuddyMainScreenState extends State<BuddyMainScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthService auths = new AuthService();
  initState() {
    super.initState();
    var z = auths.userId();

    print("authservice ${z}");

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

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          SingleChildScrollView(
            child: tabbar(),
            scrollDirection: Axis.horizontal,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          BuddyListAdapter(items, onItemClick).getView(),
        ],
      ),
    ));
  }

  Widget tabbar() {
    return Row(
      children: [
        Container(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: MyColors.accent,
              elevation: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("HOME",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          onPressed: () {
            //delayShowingContent();
          },
        ),
        Container(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: MyColors.accent,
              elevation: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("TOP ARTISTS",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          onPressed: () {
            //delayShowingContent();
          },
        ),
        Container(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: MyColors.accent,
              elevation: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("TOP ALBUMS",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          onPressed: () {
            //delayShowingContent();
          },
        ),
        Container(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: MyColors.accent,
              elevation: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("NEW RELEASES",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          onPressed: () {
            //delayShowingContent();
          },
        ),
        Container(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: MyColors.accent,
              elevation: 1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("TOP SONGS",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          onPressed: () {
            //delayShowingContent();
          },
        ),
        Container(width: 10),
      ],
    );
  }
}
