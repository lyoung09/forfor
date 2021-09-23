import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  CollectionReference user = FirebaseFirestore.instance.collection('users');
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

  Widget tabbar() {
    return Row(children: [
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
          child:
              Text("new", style: TextStyle(color: Colors.black, fontSize: 14)),
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
            }
          });
        },
      ),
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
          child:
              Text("카테고리", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
          setState(() {
            categoryClick = !categoryClick;
            if (categoryClick) {
              newClick = false;

              nearClick = false;
              genderClick = false;
              sameCountryClick = false;
            }
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
          child:
              Text("주변", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          setState(() {
            nearClick = !nearClick;
            if (nearClick) {
              categoryClick = false;
              newClick = false;
              genderClick = false;
              sameCountryClick = false;
            }
          });
          //delayShowingContent();
        },
      ),
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: genderClick == true
                  ? BorderSide(color: Colors.black)
                  : BorderSide(color: Colors.white),
            ),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("성별", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          //delayShowingContent();
          setState(() {
            genderClick = !genderClick;
            if (genderClick) {
              categoryClick = false;
              newClick = false;
              nearClick = false;
              sameCountryClick = false;
            }
          });
        },
      ),
      Container(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: sameCountryClick == true
                  ? BorderSide(color: Colors.black)
                  : BorderSide(color: Colors.white),
            ),
            primary: Colors.white,
            elevation: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Text("내국인", style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
        onPressed: () {
          setState(() {
            sameCountryClick = !sameCountryClick;
            if (sameCountryClick) {
              categoryClick = false;
              newClick = false;
              nearClick = false;
              genderClick = false;
            }
          });
          //delayShowingContent();
        },
      ),
    ]);
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

          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                categoryData.data!.docs[index]["categoryName"],
                                style: TextStyle(
                                    color: Colors.grey[900], fontSize: 18)),
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

  Widget gridviewWidget(email, string, detail) {
    var futureUser;
    if (string == "category")
      futureUser = user.where("category", arrayContains: detail).get();
    if (string == "new")
      futureUser = user
          .where("email", isNotEqualTo: email)
          .where("gender", isEqualTo: "여")
          .get();
    if (string == "near")
      futureUser = user.where("gender", isEqualTo: "여").get();
    if (string == "gender")
      futureUser = user.where("gender", isEqualTo: "여").get();
    if (string == "sameCountry")
      futureUser = user.where("country", isEqualTo: detail).get();
    if (string == "") futureUser = user.where("uid", isNotEqualTo: uid).get();
    return FutureBuilder(
        future: futureUser,
        builder: (context, AsyncSnapshot<QuerySnapshot> userData) {
          if (!userData.hasData) {
            return Text("");
          } else {
            return GridView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: userData.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10, //수직 Padding
              ),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(4),
              itemBuilder: (BuildContext context, int index) {
                // if (userData.data!.docs[index]["uid"] == uid) {
                //   return Container(height: 0, width: 0, child: Text("hello"));
                // }
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "${userData.data!.docs[index]["nickname"]}",
                            descriptions:
                                "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                            img: '${userData.data!.docs[index]["url"]}',
                            text: "Yes",
                          );
                        });
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      elevation: 30,
                      shadowColor: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, bottom: 2),
                                child: ClipOval(
                                  child: Image.network(
                                    "${userData.data!.docs[index]['url']}",
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8.0),
                                    child: Text(
                                      "국기",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8.0),
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
                                right: 4, left: 15, bottom: 5, top: 5),
                            child: Text(
                              userData.data!.docs[index]['nickname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 4, left: 5, bottom: 5),
                            child: Text(
                              userData.data!.docs[index]['email'],
                              //"userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            );
          }
        });
  }

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
                            string = "category";
                            categoryClick = !categoryClick;
                            if (categoryClick) {
                              newClick = false;

                              nearClick = false;
                              genderClick = false;
                              sameCountryClick = false;
                            }
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
                            }
                            string = "new";
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
                            }
                            string = "near";
                          });
                          //delayShowingContent();
                        },
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: genderClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("성별",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          //delayShowingContent();
                          setState(() {
                            genderClick = !genderClick;
                            if (genderClick) {
                              categoryClick = false;
                              newClick = false;
                              nearClick = false;
                              sameCountryClick = false;
                            }
                            string = "gender";
                          });
                        },
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: sameCountryClick == true
                                  ? BorderSide(color: Colors.black)
                                  : BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            elevation: 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("내국인",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ),
                        onPressed: () {
                          setState(() {
                            sameCountryClick = !sameCountryClick;
                            if (sameCountryClick) {
                              categoryClick = false;
                              newClick = false;
                              nearClick = false;
                              genderClick = false;
                            }
                            string = "sameCountry";
                            detail = datas["country"];
                          });
                          //delayShowingContent();
                        },
                      ),
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
                gridviewWidget(datas["email"], string, detail)
              ],
            ),
          ));
        });
  }
}
