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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: new Text("Profile",
              style: TextStyle(color: Colors.black, fontSize: 32)),
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
            print(category.length);

            return ListView(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20)),
                                      snapshot.user.url == null
                                          ? CircleAvatar(
                                              radius: 60,
                                              backgroundColor: Colors.grey[400],
                                              child:
                                                  Icon(Icons.person, size: 50))
                                          : CircleAvatar(
                                              radius: 60,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  snapshot.user.url ?? ""),
                                            ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1)),
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                    snapshot.user.nickname ??
                                                        "User",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 37)),
                                              ),
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
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: FutureBuilder(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection("category")
                                                      .where("categoryId",
                                                          whereIn: [
                                                        for (int i = 0;
                                                            i < category.length;
                                                            i++)
                                                          category[i]
                                                        //   category[0],
                                                        // category[1],
                                                        // category[2],
                                                        // category[3],
                                                        // category[4],
                                                      ]).get(),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              QuerySnapshot>
                                                          categoryData) {
                                                    if (categoryData.hasData) {
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
                                                              (context, count) {
                                                            return Chip(
                                                              label: Text(
                                                                categoryData
                                                                        .data!
                                                                        .docs[count]
                                                                    [
                                                                    "categoryName"],
                                                              ),
                                                            );
                                                          });
                                                    }
                                                    return Text("??");
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 20, top: 20)),
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
                                                      color: Colors.grey[400])
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
