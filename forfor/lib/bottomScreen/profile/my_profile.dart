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
          actions: <Widget>[
            // overflow menu
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SettingFlatRoute();
                    },
                  ),
                );
              },
            ), // overflow menu
          ]),
      body: ListView(children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(height: 35),
              InkWell(
                onTap: () {
                  print("hello");
                },
                child: Container(
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
              ),
              Container(height: 15),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text("Julianna Carter",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
              ),
              Container(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     InkWell(
              //       child: Container(
              //         width: 60,
              //         height: 60,
              //         child: Icon(Icons.person_add, color: Colors.black),
              //       ),
              //       onTap: () {},
              //     ),
              //     Container(width: 20),
              //     InkWell(
              //       child: Container(
              //         width: 60,
              //         height: 60,
              //         child: Icon(Icons.chat, color: Colors.black),
              //       ),
              //       onTap: () {},
              //     ),
              //     Container(width: 20),
              //     InkWell(
              //       child: Container(
              //         width: 60,
              //         height: 60,
              //         child: Icon(Icons.edit, color: Colors.black),
              //       ),
              //       onTap: () {},
              //     ),
              //   ],
              // ),
              // Divider(height: 50),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text("1.5 K",
                            style: MyText.title(context)!.copyWith(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.bold)),
                        Container(height: 5),
                        Text("followers",
                            style: MyText.medium(context)
                                .copyWith(color: Colors.grey[500]))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text("17.8 K",
                            style: MyText.title(context)!.copyWith(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.bold)),
                        Container(height: 5),
                        Text("buddy",
                            style: MyText.medium(context)
                                .copyWith(color: Colors.grey[500]))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text("1.3 K",
                            style: MyText.title(context)!.copyWith(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.bold)),
                        Container(height: 5),
                        Text("Following",
                            style: MyText.medium(context)
                                .copyWith(color: Colors.grey[500]))
                      ],
                    ),
                  ),
                ],
              ),
              Divider(height: 50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(MyStrings.middle_lorem_ipsum,
                    textAlign: TextAlign.center,
                    style: MyText.subhead(context)!
                        .copyWith(color: Colors.grey[900])),
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
                        Text("Your inviting",
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
                        Icon(Icons.credit_card, color: MyColors.grey_60),
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
