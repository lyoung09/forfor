import 'package:flutter/material.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/login/screen/login_main.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';

class SettingFlatRoute extends StatefulWidget {
  SettingFlatRoute();

  @override
  SettingFlatRouteState createState() => new SettingFlatRouteState();
}

class SettingFlatRouteState extends State<SettingFlatRoute> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    bool isSwitched1 = true, isSwitched2 = true;
    bool isSwitched3 = true, isSwitched4 = true;
    bool isSwitched5 = false, isSwitched6 = false;

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Spacer(),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text("Settings",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Text("change cateogry",
                        style: MyText.subhead(context)!.copyWith(
                            color: MyColors.grey_90,
                            fontWeight: FontWeight.bold)),
                    // Spacer(),
                    // Text("language",
                    //     style: MyText.subhead(context)!
                    //         .copyWith(color: MyColors.primary)),
                    // Container(width: 10)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("위치 허용",
                            style: MyText.subhead(context)!.copyWith(
                                color: MyColors.grey_90,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                            });
                          },
                          activeColor: MyColors.primary,
                          inactiveThumbColor: Colors.grey,
                        )
                      ],
                    ),
                    Text(MyStrings.middle_lorem_ipsum,
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Container(height: 15)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("personal message",
                            style: MyText.subhead(context)!.copyWith(
                                color: MyColors.grey_90,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                            });
                          },
                          activeColor: MyColors.primary,
                          inactiveThumbColor: Colors.grey,
                        )
                      ],
                    ),
                    Text("Sound during gameplay",
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Container(height: 15)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            Container(height: 25),
            Container(
              child: Text("알림",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("개인 메시지",
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Spacer(),
                    Switch(
                      value: isSwitched3,
                      onChanged: (value) {
                        setState(() {
                          isSwitched3 = value;
                        });
                      },
                      activeColor: MyColors.primary,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("그룹 메시지",
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Spacer(),
                    Switch(
                      value: isSwitched4,
                      onChanged: (value) {
                        setState(() {
                          isSwitched4 = value;
                        });
                      },
                      activeColor: MyColors.primary,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("초대 알림",
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Spacer(),
                    Switch(
                      value: isSwitched5,
                      onChanged: (value) {
                        setState(() {
                          isSwitched5 = value;
                        });
                      },
                      activeColor: MyColors.primary,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("QnA 댓글 알림",
                        style: MyText.body1(context)!
                            .copyWith(color: Colors.grey[400])),
                    Spacer(),
                    Switch(
                      value: isSwitched6,
                      onChanged: (value) {
                        setState(() {
                          isSwitched6 = value;
                        });
                      },
                      activeColor: MyColors.primary,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            Container(height: 25),
            Container(
              child: Text("More",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("위치 허용",
                    style: MyText.body1(context)!
                        .copyWith(color: Colors.grey[400])),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                controller.logoutUser();
                Get.offAll(Login());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("로그아웃",
                    style: MyText.body1(context)!
                        .copyWith(color: Colors.grey[400])),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                controller.logoutTalk();
                Get.offAll(Login());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("계정삭제",
                    style: MyText.body1(context)!
                        .copyWith(color: Colors.grey[400])),
              ),
            ),
            Divider(height: 0),
            Container(height: 15),
          ],
        ),
      ),
    );
  }
}
