import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HopeInfomation extends StatefulWidget {
  const HopeInfomation({Key? key}) : super(key: key);

  @override
  _HopeInfomationState createState() => _HopeInfomationState();
}

class _HopeInfomationState extends State<HopeInfomation> {
  bool select1 = false;
  bool select2 = false;
  bool select3 = false;

  int a = 0;
  int b = 0;
  int c = 0;

  var list1 = [0, 0, 0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  categorySave(index) async {
    if (a == 0 && select3 == false) {
      a = index;
      select1 = true;
      print('hoit${a}');
    } else if (a != 0 && select3 == true) {
      a = index;
      select1 = true;
      print('hoit2${a}');
    } else if (b == 0 && select1 == false) {
      b = index;
      select2 = true;
      print('hoit3${b}');
    } else if (b != 0 && select1 == true) {
      b = index;
      select2 = true;
      print('hoit4${b}');
    } else if (c == 0 && select2 == false) {
      c = index;
      select3 = true;
      print('hoit5${c}');
    } else if (c != 0 && select2 == true) {
      c = index;
      select3 = true;
      print('hoit6${c}');
    } 

    setState(() {});
  }

  next() {}
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.06,
          centerTitle: true,
          // backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "my infomation",
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('category').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading...");
            } else {
              return Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                            //maxCrossAxisExtent: 250,

                            crossAxisCount: 2,
                          ),
                          itemBuilder: (ctx, index) {
                            DocumentSnapshot user = snapshot.data!.docs[index];

                            return Container(
                              width: 75,
                              height: 75,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      categorySave(snapshot.data!.docs[index]
                                          ['categoryId'])
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          )),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            child: Image.network(
                                              snapshot.data!.docs[index]
                                                  ['categoryImage'],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(snapshot
                                              .data!.docs[index]['categoryName']
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: next,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "0 / 3",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
