import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/userProfile.dart';
import 'package:forfor/model/scientist.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class InvitePersonScreen extends StatefulWidget {
  const InvitePersonScreen({Key? key}) : super(key: key);

  @override
  _InvitePersonScreenState createState() => _InvitePersonScreenState();
}

class _InvitePersonScreenState extends State<InvitePersonScreen> {
  int? _index;

  bool click = false;
  bool categoryClick = false;
  bool newClick = false;
  bool nearClick = false;
  bool genderClick = false;
  bool sameCountryClick = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var detail;
  var uid;

  initState() {
    super.initState();
    uid = auth.currentUser?.uid;
    print(uid);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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

  Widget _buildGridView(AsyncSnapshot<Object> userList) {
    double radius = 5.0;
    return InkWell(
      onTap: () {
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return CustomDialogBox(
        //         title: "${userList.data!.docs[position]["categoryId"]}",
        //         descriptions:
        //             "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
        //         img: Image.network('${userList.image}'),
        //         text: "Yes",
        //       );
        //     });
      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          elevation: 30,
          shadowColor: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8, bottom: 2),
                    child: ClipOval(
                      child: Image.network(
                        "${userList.data!}",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                        child: Text(
                          "국기",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                        child: Text(
                          "0.1km",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 4, left: 15, bottom: 8, top: 8),
                child: Text(
                  // scientist.name,
                  "1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, left: 8, bottom: 8),
                child: Text(
                  // scientist.desc,
                  "1",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  CollectionReference user = FirebaseFirestore.instance.collection('users');
  Widget gridviewWidget(string, detail) {
    var exceptMyself = FirebaseFirestore.instance
        .collection('users')
        .where("uid", isNotEqualTo: uid);

    var futureUser;
    if (string == "category") print(detail);
    futureUser = exceptMyself.where("category", arrayContains: detail).get();

    if (string == "new")
      futureUser = exceptMyself.orderBy("timeStamp", descending: true).get();
    if (string == "near")
      futureUser =
          exceptMyself.where("email", isEqualTo: "lyoung09@hanmail.net").get();
    if (string == "gender")
      futureUser = exceptMyself.where("gender", isEqualTo: detail).get();
    if (string == "sameCountry")
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

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserProfile(
                              uid: userData.data!.docs[index]["uid"]);
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
                    height: 120,
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, top: 15),
                                child: Text(
                                  userData.data!.docs[index]['nickname'],

                                  // userData
                                  //     .data!.docs[index]['category'].runtimeType
                                  //     .toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, bottom: 5),
                                child: Text(
                                  userData.data!.docs[index]['introduction'] ??
                                      "",
                                  // "userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
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
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'icons/flags/png/${userData.data!.docs[index]['country']}.png',
                                    package: 'country_icons'),
                                backgroundColor: Colors.white,
                                radius: 17,
                              ),
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

              sameCountryClick = false;
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
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .get(),
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
                      child: Text("초대하기",
                          style: TextStyle(color: Colors.black, fontSize: 30)),
                    ),
                    Spacer(),
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
                              sameCountryClick = false;
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
                              side: newClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("new",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          //delayShowingContent();
                          setState(() {
                            newClick = !newClick;
                            if (newClick) {
                              categoryClick = false;
                              nearClick = false;
                              genderClick = false;
                              sameCountryClick = false;
                              string = "new";
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
                              sameCountryClick = false;
                              string = "near";
                            } else
                              string = "";
                          });
                          //delayShowingContent();
                        },
                      ),
                      Container(width: 10),
                      _genderPopup(),

                      // Container(width: 10),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //         side: sameCountryClick == true
                      //             ? BorderSide(color: Colors.black)
                      //             : BorderSide(color: Colors.white),
                      //       ),
                      //       primary: Colors.white,
                      //       elevation: 1),
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 15),
                      //     child: Text("내국인",
                      //         style:
                      //             TextStyle(color: Colors.black, fontSize: 14)),
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       sameCountryClick = !sameCountryClick;
                      //       if (sameCountryClick) {
                      //         categoryClick = false;
                      //         newClick = false;
                      //         nearClick = false;
                      //         genderClick = false;
                      //         string = "sameCountry";
                      //         detail = datas["country"];
                      //       } else
                      //         string = "";
                      //     });
                      //     //delayShowingContent();
                      //   },
                      // ),
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
                Padding(padding: EdgeInsets.only(top: 15)),
                if (string == "category" && detail == null)
                  gridviewWidget(string, datas["category"][0])
                else
                  gridviewWidget(string, detail)
              ],
            ),
          ));
        });
  }
}
