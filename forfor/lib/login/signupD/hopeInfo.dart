import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_item/multi_select_item.dart';

class HopeInfomation extends StatefulWidget {
  const HopeInfomation({Key? key}) : super(key: key);

  @override
  _HopeInfomationState createState() => _HopeInfomationState();
}

class _HopeInfomationState extends State<HopeInfomation> {
  // ignore: deprecated_member_use

  var list1 = [0, 0, 0];
  Map<int, bool> checking = new Map();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  next() async {
    if (checking.length != 3) {
      print("u cant go");
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update({
        "category": FieldValue.arrayUnion([
          checking.keys.elementAt(0),
          checking.keys.elementAt(1),
          checking.keys.elementAt(2)
        ])
      });

      Navigator.pushNamed(context, '/bottomScreen');
    }
  }

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
            "Category",
            style: TextStyle(fontSize: 22, color: Colors.black),
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
                                    onTap: () {
                                      setState(() {
                                        checking[snapshot.data!.docs[index]
                                                        ['categoryId']] ==
                                                    null ||
                                                checking[snapshot
                                                            .data!.docs[index]
                                                        ['categoryId']] ==
                                                    false
                                            ? checking[
                                                snapshot.data!.docs[index]
                                                    ['categoryId']] = true
                                            : checking[
                                                snapshot.data!.docs[index]
                                                    ['categoryId']] = false;

                                        checking
                                            .removeWhere((k, v) => v == false);
                                        if (checking.length > 3) {
                                          if (checking.length % 3 == 1) {
                                            checking.remove(
                                                checking.entries.first.key);
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      decoration: checking[snapshot.data!
                                                  .docs[index]['categoryId']] ==
                                              true
                                          ? BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.redAccent,
                                                  width: 2.5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(23),
                                              ))
                                          : BoxDecoration(
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
                              "${checking.length} / 3",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
