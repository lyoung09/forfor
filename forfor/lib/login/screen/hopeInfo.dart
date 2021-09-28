import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';
import 'package:multi_select_item/multi_select_item.dart';

class HopeInfomation extends StatefulWidget {
  const HopeInfomation({Key? key}) : super(key: key);

  @override
  _HopeInfomationState createState() => _HopeInfomationState();
}

class _HopeInfomationState extends State<HopeInfomation>
    with WidgetsBindingObserver {
  // ignore: deprecated_member_use

  var list1 = [0, 0, 0];
  Map<int, bool> checking = new Map();

  FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.paused == state) {}
    if (AppLifecycleState.detached == state) {
      print("Status :" + state.toString());
      controller.deleteUser();
    }
  }

  next() async {
    if (checking.length != 3) {
      print("u cant go");
    } else {
      list1[0] = checking.keys.elementAt(0);
      list1[1] = checking.keys.elementAt(1);
      list1[2] = checking.keys.elementAt(2);
      controller.setUserDatabase(list1);

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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            toolbarHeight: height * 0.06,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orange[50],
            centerTitle: false,
            title: Text(
              "Category",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
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
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: next,
                        style: ElevatedButton.styleFrom(
                          primary: checking.length == 3
                              ? Colors.orange[50]
                              : Colors.white,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              side: checking.length == 3
                                  ? BorderSide(
                                      color: Colors.orange[100]!, width: 2)
                                  : BorderSide(color: Colors.black, width: 1)),
                        ),
                        child: Text(
                          "${checking.length} / 3",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18),
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
