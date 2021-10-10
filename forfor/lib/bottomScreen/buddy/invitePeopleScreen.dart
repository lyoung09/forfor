import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/bottomScreen/otherProfile/userProfile.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/model/scientist.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/model/userLocation.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'nearUser.dart';

class InvitePersonScreen extends StatefulWidget {
  const InvitePersonScreen({Key? key}) : super(key: key);

  @override
  _InvitePersonScreenState createState() => _InvitePersonScreenState();
}

class _InvitePersonScreenState extends State<InvitePersonScreen> {
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
  int val = -1;
  bool click = false;
  bool categoryClick = false;
  bool newClick = false;
  bool nearClick = false;
  bool genderClick = false;
  bool countryClick = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  var detail;
  var uid;
  final controller = Get.put(AuthController());
  final userController = Get.put(UserController());

  @override
  initState() {
    super.initState();
    uid = controller.user!.uid;
    print(userController.user.lat);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  late LocationData _currentPosition;
  final Location location = Location();

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {

    AuthController().saveLocation(controller.user!.uid,
        _currentPosition.latitude, _currentPosition.latitude);
  }

  late int selectedIndex;
  Widget category(data) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('category')
            .where("categoryId", whereIn: data["category"])
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> categoryData) {
          if (!categoryData.hasData) {
            return Text("");
          }
          if (detail == null) {
            detail = categoryData.data!.docs[0]["categoryId"];
          }
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.data!.size,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        detail = categoryData.data!.docs[index]["categoryId"];
                      });
                    },
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: detail ==
                                categoryData.data!.docs[index]["categoryId"]
                            ? Text(
                                categoryData.data!.docs[index]["categoryName"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                categoryData.data!.docs[index]["categoryName"],
                                style: TextStyle(
                                    color: Colors.grey[900], fontSize: 13)),
                      ),
                    ),
                  ),
                );
              });
        });
    // return Row(children: [
    //   Container(width: 10),
    //   InkWell(
    //     onTap: () {
    //       setState(() {
    //         click = !click;
    //       });
    //     },
    //     child: Container(
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 15),
    //         child: click == true
    //             ? Text(snapshot,
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 22,
    //                     fontWeight: FontWeight.bold))
    //             : Text("friends",
    //                 style: TextStyle(color: Colors.grey[900], fontSize: 18)),
    //       ),
    //     ),
    //   ),
    //   Container(width: 10),
    //   InkWell(
    //     onTap: () {
    //       click = !click;
    //     },
    //     child: Container(
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 15),
    //         child: Text("language",
    //             style: TextStyle(color: Colors.grey[900], fontSize: 18)),
    //       ),
    //     ),
    //   ),
    //   Container(width: 10),
    //   InkWell(
    //     onTap: () {},
    //     child: Container(
    //       child: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 15),
    //         child: Text("journey",
    //             style: TextStyle(color: Colors.grey[900], fontSize: 18)),
    //       ),
    //     ),
    //   ),
    //   Container(width: 10),
    // ]);
  }

  Widget _radio(country) {
    return Container(
      height: 50,
      width: 600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = 'ONE';
                id = 1;
                detail = "${country}";
              });
            },
          ),
          CircleAvatar(
            backgroundImage: AssetImage('icons/flags/png/${country}.png',
                package: 'country_icons'),
            backgroundColor: Colors.white,
            radius: 15,
          ),
          Radio(
            value: 2,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = 'TWO';
                id = 2;
                detail = "${country}";
              });
            },
          ),
          Text(
            'other',
            style: new TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridviewWidget(string, detail) {
    var exceptMyself = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isNotEqualTo: uid);

    var futureUser;
    if (string == "category")
      futureUser = exceptMyself.where("category", arrayContains: detail).get();

    // if (string == "new")
    //   futureUser = exceptMyself.orderBy("timeStamp", descending: true).get();
    if (string == "near")
      futureUser =
          exceptMyself.where("email", isEqualTo: "lyoung09@hanmail.net").get();
    if (string == "gender")
      futureUser = exceptMyself.where("gender", isEqualTo: detail).get();
    if (string == "country" && id == 2)
      futureUser = FirebaseFirestore.instance
          .collection('users')
          .where("country", isNotEqualTo: detail)
          .get();
    if (string == "country" && id == 1)
      futureUser = exceptMyself.where("country", isEqualTo: detail).get();
    if (string == "") futureUser = exceptMyself.get();
    return FutureBuilder(
        future: futureUser,
        builder: (context, AsyncSnapshot<QuerySnapshot> userData) {
          if (!userData.hasData) {
            return Text("");
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: userData.data!.docs.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(4),
              itemBuilder: (BuildContext context, int index) {
                // if (userData.data!.docs[index]["uid"] == uid) {
                //   return Container(height: 0, width: 0, child: Text("hello"));
                // }
                final List<int> category =
                    userData.data!.docs[index]["category"].cast<int>();

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OtherProfile(
                              uid: userData.data!.docs[index]["uid"],
                              userName: userData.data!.docs[index]["nickname"],
                              userImage: userData.data!.docs[index]["url"],
                              introduction: userData.data!.docs[index]
                                  ["introduction"]);
                        },
                      ),
                    );

                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return CustomDialogBox(
                    //         title: "${userData.data!.docs[index]["nickname"]}",
                    //         descriptions: userData.data!.docs[index]
                    //             ["category"],
                    //         img: '${userData.data!.docs[index]["url"]}',
                    //         text: "Yes",
                    //       );
                    //     });
                  },
                  child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "${userData.data!.docs[index]['url']}")),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 40,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'icons/flags/png/${userData.data!.docs[index]['country']}.png',
                                      package: 'country_icons'),
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 5, top: 8),
                                  child: Text(
                                    userData.data!.docs[index]['nickname'],
                                    // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('category')
                                          .where('categoryId', whereIn: [
                                        for (int i = 0;
                                            i <
                                                userData
                                                    .data!
                                                    .docs[index]['category']
                                                    .length;
                                            i++)
                                          category[i]
                                      ]).snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              categorySnapshot) {
                                        if (!categorySnapshot.hasData) {
                                          return Text("");
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                categorySnapshot.data!.size,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Transform(
                                                transform:
                                                    new Matrix4.identity()
                                                      ..scale(0.8),
                                                child: Chip(
                                                  backgroundColor:
                                                      Colors.orange[50],
                                                  label: Text(
                                                      categorySnapshot
                                                              .data!.docs[index]
                                                          ["categoryName"],
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              );
                                            });
                                      })),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, left: 5, bottom: 2),
                                  child: Text(
                                    userData.data!.docs[index]
                                            ['introduction'] ??
                                        "",
                                    //"userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              // CircleAvatar(
                              //   backgroundImage: AssetImage(
                              //       'icons/flags/png/${userData.data!.docs[index]['country']}.png',
                              //       package: 'country_icons'),
                              //   backgroundColor: Colors.white,
                              //   radius: 17,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 3.0),
                                child: Text(
                                  "0.1km",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  Widget _genderPopup() => PopupMenuButton<int>(
        child: Container(
          width: 80,
          height: 70,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(child: Text("성별")),
          ),
        ),
        onSelected: (value) {
          setState(() {
            value == 1 ? detail = "남" : detail = "여";
            genderClick = !genderClick;
            if (genderClick) {
              string = "gender";

              newClick = false;

              nearClick = false;
              categoryClick = false;

              countryClick = false;
            } else
              string = "";
          });
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("남성"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("여성"),
          ),
        ],
      );

  var string = "";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }

          Map<String, dynamic> datas =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Buddy",
                          style: TextStyle(color: Colors.black, fontSize: 30)),
                    ),
                    Spacer(),
                    string == "near" && snapshot.data!["lat"] == -1
                        ? Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.ac_unit_outlined),
                              onPressed: getLoc,
                            ))
                        : Text(""),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                Divider(color: Colors.black, height: 1),
                Padding(padding: EdgeInsets.only(top: 15)),
                Container(
                  height: 50,
                  child: SingleChildScrollView(
                    child: Row(children: [
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: categoryClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("카테고리",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          //delayShowingContent();
                          setState(() {
                            categoryClick = !categoryClick;
                            if (categoryClick) {
                              string = "category";
                              newClick = false;

                              nearClick = false;
                              genderClick = false;
                              countryClick = false;
                            } else
                              string = "";
                          });
                        },
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: countryClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("country",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          //delayShowingContent();
                          setState(() {
                            countryClick = !countryClick;
                            if (countryClick) {
                              categoryClick = false;
                              nearClick = false;
                              genderClick = false;
                              newClick = false;
                              string = "country";
                              id = 1;
                              detail = "${snapshot.data!["country"]}";
                            } else
                              string = "";
                          });
                        },
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: nearClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("주변",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          setState(() {
                            nearClick = !nearClick;
                            if (nearClick) {
                              categoryClick = false;
                              newClick = false;
                              genderClick = false;
                              countryClick = false;
                              string = "near";
                            } else
                              string = "";
                          });
                          //delayShowingContent();
                        },
                      ),
                      Container(width: 10),
                      _genderPopup(),
                    ]),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                categoryClick == true
                    ? Container(
                        height: 50,
                        child: SingleChildScrollView(
                          child: category(snapshot.data),
                          scrollDirection: Axis.horizontal,
                        ))
                    : Container(
                        height: 0,
                      ),
                countryClick == true
                    ? _radio(snapshot.data!["country"])
                    : Container(
                        height: 0,
                      ),
                Padding(padding: EdgeInsets.only(top: 15)),
                if (string == "category" && detail == null)
                  gridviewWidget(string, datas["category"][0]),
                if (string == "near")
                  // DistanceUser(
                  //   uid: snapshot.data!["uid"],
                  // )
                  // DistanceUser(
                  //   uid: snapshot.data!['uid'],
                  // )
                  DistanceUser(
                      uid: snapshot.data!['uid'],
                      lat: snapshot.data!['lat'],
                      lng: snapshot.data!['lng'])
                else
                  gridviewWidget(string, detail)
              ],
            ),
          ));
        });
  }
}
