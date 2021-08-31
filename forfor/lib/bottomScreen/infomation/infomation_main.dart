import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'infomationDetail/AlarmPage.dart';
import 'infomationDetail/WritingPage.dart';

class InformationMainScreen extends StatefulWidget {
  const InformationMainScreen({Key? key}) : super(key: key);

  @override
  _InformationMainScreenState createState() => _InformationMainScreenState();
}

class _InformationMainScreenState extends State<InformationMainScreen>
    with TickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TabController tabController;
  initState() {
    super.initState();

    userInformation();

    tabController = new TabController(length: 3, vsync: this);
  }

  userInformation() {
    print(auth.currentUser?.uid);
  }

  CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('category');

  userWantsCategory() {}

  Widget _category(data) {
    return FutureBuilder(
      future: categoryRef.where("categoryId", whereIn: [
        data["category1"],
        data["category2"],
        data["category3"]
      ]).get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> categoryData) {
        if (!categoryData.hasData) {
          return Text("Loading..");
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categoryData.data!.docs.length,
              itemBuilder: (context, position) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.1,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 10),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        child: InkWell(
                            child: SizedBox(
                              width: 85,
                              height: 85,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, top: 8.0, bottom: 1.0),
                                  ),
                                  Image.network(
                                    categoryData.data!.docs[position]
                                        ["categoryImage"],
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                  ),
                                  Text(
                                    categoryData.data!.docs[position]
                                        ["categoryName"],
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {}),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  int? selectedIndex;
  Widget _categoryList(data) {
    return FutureBuilder(
      future: categoryRef.where("categoryId", whereIn: data["category"]).get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> categoryData) {
        if (!categoryData.hasData) {
          return Text("Loading..");
        }

        //if (selectedIndex == null) selectedIndex = data["category1"];

        return SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categoryData.data!.docs.length,
              itemBuilder: (context, position) {
                selectedIndex ??= categoryData.data!.docs[0]["categoryId"];

                return InkWell(
                  onTap: () {
                    setState(() {
                      //selectedIndex = index;
                      selectedIndex =
                          categoryData.data!.docs[position]["categoryId"];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),

                          margin: EdgeInsets.only(
                              top: 5, bottom: 15), //top padding 5
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 1.4,
                            color: selectedIndex ==
                                    categoryData.data!.docs[position]
                                        ["categoryId"]
                                ? Colors.black
                                : Colors.transparent,
                          ))),

                          child: FittedBox(
                            child: Text(
                              categoryData.data!.docs[position]["categoryName"],
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: selectedIndex ==
                                        categoryData.data!.docs[position]
                                            ["categoryId"]
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  int _index = 0;
  Widget _bestInformation() {
    return PageView.builder(
      itemCount: 10,
      controller: PageController(viewportFraction: 0.7),
      onPageChanged: (int index) => setState(() => _index = index),
      itemBuilder: (_, i) {
        return Transform.scale(
            scale: i == _index ? 1 : 0.9,
            child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Card ${i + 1}",
                    style: TextStyle(fontSize: 32),
                  ),
                )));
      },
    );
  }

  Widget _categoryListInformation() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (_, i) {
        print(i);
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Stack(
                              fit: StackFit.expand,
                              overflow: Overflow.visible,
                              children: [
                                CircleAvatar(
                                    backgroundImage:
                                        //NetworkImage('${snapshot.data!['url']}'),
                                        AssetImage("assets/icon/email.png")),
                                Positioned(
                                  left: -5,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Align(alignment: Alignment.topRight, child: Text("12")),
                        Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  writingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return WritingPage();
        },
      ),
    );
  }

  alarmPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AlarmPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('users').doc(auth.currentUser?.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        }

        //snapshot.data!['category3'];

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              shape: Border(bottom: BorderSide(color: Colors.black, width: 1)),
              actions: [
                IconButton(
                    onPressed: alarmPage,
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: writingPage,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 200.0,
                  floating: false,
                  title: _categoryList(snapshot.data),
                  pinned: false,
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(top: 70.0, bottom: 20),
                      child: _bestInformation(),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Container(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Expanded(child: _categoryListInformation()),

                //),
              ],
            ),
          ),
        );
      },
    );
  }
}
