import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/profile/my_update.dart';
import 'package:forfor/bottomScreen/profile/settings.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';

import 'change_category.dart';

// class MyProfile extends StatefulWidget {
//   const MyProfile({Key? key}) : super(key: key);

//   @override
//   _MyProfileState createState() => _MyProfileState();
// }

class MyProfile extends GetWidget<AuthController> {
  updateUser() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return UserUpdate();
    //     },
    //   ),
    // );
    Get.to(() => UserUpdate());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0), // here the desired height

          child: AppBar(
            centerTitle: false,
            backgroundColor: Colors.orange[50],
            automaticallyImplyLeading: false,
            title: new Text("Profile",
                style: TextStyle(color: Colors.black, fontSize: 30)),
          ),
        ),
        body: GetX<UserController>(initState: (_) async {
          Get.find<UserController>().user = await UserDatabase()
              .getUser(Get.find<AuthController>().user!.uid);
        }, builder: (snapshot) {
          if (snapshot.user.id == null) {
            Text("loading");
          }

          if (snapshot.user.id != null) {
            final List<int> category = snapshot.user.category!.cast<int>();

            return ListView(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          // Container(height: 10),
                          InkWell(
                              onTap: updateUser,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01)),
                                      snapshot.user.url == null
                                          ? Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: CircleAvatar(
                                                    radius: 45,
                                                    backgroundColor:
                                                        Colors.grey[400],
                                                    child: Icon(Icons.person,
                                                        size: 50)),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: CircleAvatar(
                                                  radius: 45,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                      snapshot.user.url ?? ""),
                                                ),
                                              ),
                                            ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03)),
                                      Expanded(
                                        flex: 8,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: 135,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                    snapshot.user.nickname ??
                                                        "User",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 33)),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                      snapshot.user.category
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection("category")
                                                        .where("categoryId",
                                                            whereIn: [
                                                          for (int i = 0;
                                                              i <
                                                                  category
                                                                      .length;
                                                              i++)
                                                            category[i]
                                                          // 1,
                                                          // 2,
                                                          // 3,
                                                          // 4,
                                                          // 5,
                                                        ]).get(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            categoryData) {
                                                      if (categoryData
                                                          .hasData) {
                                                        print(categoryData
                                                                .data!.docs[0]
                                                            ['categoryName']);

                                                        return GridView.builder(
                                                            gridDelegate:
                                                                new SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        3,

                                                                    // childAspectRatio: MediaQuery.of(
                                                                    //             context)
                                                                    //         .size
                                                                    //         .width /
                                                                    //     (MediaQuery.of(
                                                                    //                 context)
                                                                    //             .size
                                                                    //             .height /
                                                                    //         3),
                                                                    childAspectRatio:
                                                                        180 /
                                                                            100),
                                                            itemCount:
                                                                categoryData
                                                                    .data!.size,
                                                            itemBuilder:
                                                                (context,
                                                                    count) {
                                                              return Chip(
                                                                  backgroundColor:
                                                                      Colors.orange[
                                                                          50],
                                                                  // avatar: CircleAvatar(
                                                                  //     radius:
                                                                  //         100,
                                                                  //     backgroundColor:
                                                                  //         Colors.orange[
                                                                  //             50],
                                                                  //     backgroundImage: NetworkImage(categoryData
                                                                  //             .data!
                                                                  //             .docs[count]
                                                                  //         [
                                                                  //         "categoryImage"])),
                                                                  label: Text(categoryData
                                                                          .data!
                                                                          .docs[count]
                                                                      [
                                                                      "categoryName"]));
                                                            });
                                                      }
                                                      return Text("??");
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  //////////////////////
                                  //////////////////////
                                  ///////user vip////////
                                  /////////category 6////////
                                  //////////////////////
                                  //////////////////////
                                  // Row(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //         padding: EdgeInsets.only(
                                  //             left: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width *
                                  //                 0.01)),
                                  //     snapshot.user.url == null
                                  //         ? Expanded(
                                  //             flex: 3,
                                  //             child: Container(
                                  //               alignment: Alignment.topLeft,
                                  //               width: MediaQuery.of(context)
                                  //                       .size
                                  //                       .width *
                                  //                   0.25,
                                  //               child: CircleAvatar(
                                  //                   radius: 45,
                                  //                   backgroundColor:
                                  //                       Colors.grey[400],
                                  //                   child: Icon(Icons.person,
                                  //                       size: 50)),
                                  //             ),
                                  //           )
                                  //         : Expanded(
                                  //             flex: 3,
                                  //             child: Container(
                                  //               child: CircleAvatar(
                                  //                 radius: 45,
                                  //                 backgroundColor: Colors.white,
                                  //                 backgroundImage: NetworkImage(
                                  //                     snapshot.user.url ?? ""),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //     Padding(
                                  //         padding: EdgeInsets.only(
                                  //             left: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width *
                                  //                 0.03)),
                                  //     Expanded(
                                  //       flex: 8,
                                  //       child: Container(
                                  //         alignment: Alignment.topLeft,
                                  //         height: 165,
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             Container(
                                  //               child: Text(
                                  //                   snapshot.user.nickname ??
                                  //                       "User",
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   maxLines: 1,
                                  //                   style: TextStyle(
                                  //                       fontSize: 33)),
                                  //             ),
                                  //             Container(
                                  //               child: Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(5),
                                  //                 child: Text(
                                  //                     snapshot.user.category
                                  //                         .toString(),
                                  //                     overflow:
                                  //                         TextOverflow.ellipsis,
                                  //                     maxLines: 1,
                                  //                     style: TextStyle(
                                  //                         fontSize: 15)),
                                  //               ),
                                  //             ),
                                  //             Container(
                                  //               height: 90,
                                  //               width: MediaQuery.of(context)
                                  //                       .size
                                  //                       .width *
                                  //                   0.7,
                                  //               child: FutureBuilder(
                                  //                   future: FirebaseFirestore
                                  //                       .instance
                                  //                       .collection("category")
                                  //                       .where("categoryId",
                                  //                           whereIn: [
                                  //                         // for (int i = 0;
                                  //                         //     i <
                                  //                         //         category
                                  //                         //             .length;
                                  //                         //     i++)
                                  //                         //   category[i]
                                  //                         1,
                                  //                         2,
                                  //                         3,
                                  //                         4,
                                  //                         5,
                                  //                       ]).get(),
                                  //                   builder: (context,
                                  //                       AsyncSnapshot<
                                  //                               QuerySnapshot>
                                  //                           categoryData) {
                                  //                     if (categoryData
                                  //                         .hasData) {
                                  //                       print(categoryData
                                  //                               .data!.docs[0]
                                  //                           ['categoryName']);

                                  //                       return GridView.builder(
                                  //                           gridDelegate:
                                  //                               new SliverGridDelegateWithFixedCrossAxisCount(
                                  //                                   crossAxisCount:
                                  //                                       3,

                                  //                                   // childAspectRatio: MediaQuery.of(
                                  //                                   //             context)
                                  //                                   //         .size
                                  //                                   //         .width /
                                  //                                   //     (MediaQuery.of(
                                  //                                   //                 context)
                                  //                                   //             .size
                                  //                                   //             .height /
                                  //                                   //         3),
                                  //                                   childAspectRatio:
                                  //                                       180 /
                                  //                                           100),
                                  //                           itemCount:
                                  //                               categoryData
                                  //                                   .data!.size,
                                  //                           itemBuilder:
                                  //                               (context,
                                  //                                   count) {
                                  //                             return Chip(
                                  //                                 backgroundColor:
                                  //                                     Colors.orange[
                                  //                                         50],
                                  //                                 // avatar: CircleAvatar(
                                  //                                 //     radius:
                                  //                                 //         100,
                                  //                                 //     backgroundColor:
                                  //                                 //         Colors.orange[
                                  //                                 //             50],
                                  //                                 //     backgroundImage: NetworkImage(categoryData
                                  //                                 //             .data!
                                  //                                 //             .docs[count]
                                  //                                 //         [
                                  //                                 //         "categoryImage"])),
                                  //                                 label: Text(categoryData
                                  //                                         .data!
                                  //                                         .docs[count]
                                  //                                     [
                                  //                                     "categoryName"]));
                                  //                           });
                                  //                     }
                                  //                     return Text("??");
                                  //                   }),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  Padding(padding: EdgeInsets.only(top: 8)),
                                  Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Text(
                                              snapshot.user.introduction ?? "",

                                              // "write yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourself",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style:
                                                  //userModel.introduction == null

                                                  //  ?
                                                  TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12)
                                              // : MyText.subhead(context)!
                                              //     .copyWith(
                                              //         color: Colors.grey[900])
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icon/invite.png',
                                width: 35,
                                height: 35,
                              ),
                              Container(height: 5),
                              Text("invite",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 20))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              height: 80,
                              child: VerticalDivider(color: Colors.grey[400])),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icon/buddy.png',
                                width: 35,
                                height: 30,
                              ),
                              Container(height: 5),
                              Text("buddy",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 20))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              height: 80,
                              child: VerticalDivider(color: Colors.grey[400])),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icon/group.png',
                                width: 35,
                                height: 35,
                              ),
                              Container(height: 5),
                              Text("group",
                                  style: TextStyle(
                                      color: Colors.grey[900], fontSize: 20))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 50),
                    Column(children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          child: Row(
                            children: <Widget>[
                              Text("내 그룹 설정",
                                  style: MyText.medium(context).copyWith(
                                      color: MyColors.grey_80,
                                      fontWeight: FontWeight.w300)),
                              Spacer(),
                              Image.asset(
                                'assets/icon/groupSetting.png',
                                width: 35,
                                height: 35,
                              ),
                              Container(width: 10)
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          child: Row(
                            children: <Widget>[
                              Text("QnA",
                                  style: MyText.medium(context).copyWith(
                                      color: MyColors.grey_80,
                                      fontWeight: FontWeight.w300)),
                              Spacer(),
                              Image.asset(
                                'assets/icon/question.png',
                                width: 35,
                                height: 35,
                              ),
                              Container(width: 10)
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SettingFlatRoute();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          child: Row(
                            children: <Widget>[
                              Text("settings",
                                  style: MyText.medium(context).copyWith(
                                      color: MyColors.grey_80,
                                      fontWeight: FontWeight.w300)),
                              Spacer(),
                              Icon(Icons.settings, color: MyColors.grey_60),
                              Container(width: 10)
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          child: Row(
                            children: <Widget>[
                              Text("VIP",
                                  style: MyText.medium(context).copyWith(
                                      color: MyColors.grey_80,
                                      fontWeight: FontWeight.w300)),
                              Spacer(),
                              Icon(Icons.credit_card, color: MyColors.grey_60),
                              Container(width: 10)
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(height: 50),
                  ],
                ),
              ),
            ]);
          }
          return Center(child: Text("loading"));
        }));
  }
}
