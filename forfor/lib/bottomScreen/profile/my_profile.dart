import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/profile/my_update.dart';
import 'package:forfor/bottomScreen/profile/settings.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';

import 'change_category.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final controller = Get.put(UserController());

  initState() {
    super.initState();
    print(controller.user.nickname);
    print(controller.user.email);
    print(controller.user.gender);
  }

  updateUser() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return UserUpdate();
        },
      ),
    );
  }

  changeCategory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChagneCategory();
        },
      ),
    );
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
      body: ListView(children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.grey[400]),
                child: Column(
                  children: [
                    Container(height: 25),
                    InkWell(
                      onTap: updateUser,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/icon/userSetting.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.purple[600],
                      child: CircleAvatar(
                        radius: 49,
                        backgroundImage:
                            AssetImage('assets/image/photo_female_1.jpg'),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10, top: 10)),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("JulJul",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: MyText.headline(context)!.copyWith(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10, top: 10)),
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
                            child: Text(
                                "MyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsumMyStrings.middle_lorem_ipsum",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: MyText.subhead(context)!
                                    .copyWith(color: Colors.grey[900])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 20),
              Container(
                  padding: EdgeInsets.all(9),
                  child: Divider(
                    color: Colors.grey[400],
                    thickness: 1.2,
                  )),
              Divider(height: 30),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
      ]),
    );
  }
}
