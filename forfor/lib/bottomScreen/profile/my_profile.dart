import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/profile/settings.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        title: new Text("View Profile"),
      ),
      body: ListView(children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(height: 35),
              InkWell(onTap: (){},child:
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 49,
                            backgroundImage:
                                AssetImage(Img.get("photo_female_5.jpg")),
                          ),
                        )),
                    Container(height: 15),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Text("Julianna Carter",
                          style: MyText.headline(context)!.copyWith(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(MyStrings.middle_lorem_ipsum,
                          textAlign: TextAlign.center,
                          style: MyText.subhead(context)!
                              .copyWith(color: Colors.grey[900])),
                    ),
                    Container(height: 15),
                  ],
                ),
              )),
              Divider(height: 30),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/icon/invite.png',
                          width: 35,
                          height: 35,
                        ),
                        Container(height: 5),
                        Text("< invited",
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 20))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
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
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/icon/invite.png',
                          width: 35,
                          height: 35,
                        ),
                        Container(height: 5),
                        Text("inviting >",
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
                        Text("Your group",
                            style: MyText.medium(context).copyWith(
                                color: MyColors.grey_80,
                                fontWeight: FontWeight.w300)),
                        Spacer(),
                        Icon(Icons.picture_in_picture, color: MyColors.grey_60),
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
                        Icon(Icons.people_outline, color: MyColors.grey_60),
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
