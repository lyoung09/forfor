import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/adapter/buddylistAdapter.dart';
import 'package:forfor/data/dummy.dart';
import 'package:forfor/model/people.dart';
import 'package:forfor/widget/my_colors.dart';

class BuddyMainScreen extends StatefulWidget {
  const BuddyMainScreen({Key? key}) : super(key: key);

  @override
  _BuddyMainScreenState createState() => _BuddyMainScreenState();
}

class _BuddyMainScreenState extends State<BuddyMainScreen> {
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

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Text("친구찾기",
                  style: TextStyle(color: Colors.black, fontSize: 25))),
          Padding(padding: EdgeInsets.only(top: 20)),
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
          _selectC == true
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: categorySelect(),
                  ),
                  scrollDirection: Axis.horizontal,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          BuddyListAdapter(items, onItemClick).getView(),
        ],
      ),
    ));
  }

  Widget categorySelect() {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: Text(
              "그룹",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        Padding(padding: EdgeInsets.only(right: 10)),
        Container(
            decoration: BoxDecoration(border: Border.all(width: 3)),
            child: Text(
              "주변",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        Padding(padding: EdgeInsets.only(right: 10)),
        Container(
            decoration: BoxDecoration(border: Border.all(width: 3)),
            child: Text(
              "성별",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        Padding(padding: EdgeInsets.only(right: 10)),
        Container(
            child: Text(
          "추천",
          style: TextStyle(color: Colors.black, fontSize: 20),
        )),
        Padding(padding: EdgeInsets.only(right: 10)),
      ],
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
          child: Text("foood",
              style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
          setState(() {
            _selectC = true;
          });
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
          child: Text("living",
              style: TextStyle(color: Colors.black, fontSize: 14)),
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
          child: Text("language",
              style: TextStyle(color: Colors.black, fontSize: 14)),
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
          child: Text("TOP ALBUMS",
              style: TextStyle(color: Colors.black, fontSize: 14)),
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
          child: Text("TOP ALBUMS",
              style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
        },
      ),
      Container(width: 10),
    ]);
  }
}
