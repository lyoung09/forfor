import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class UserUpdate extends StatefulWidget {
  const UserUpdate({Key? key}) : super(key: key);

  @override
  _UserUpdateState createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  final AuthController controller = Get.put(AuthController());
  var _image;
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _introductionControl =
      new TextEditingController();
  bool checkNickname = true;
  bool categoryButtonClick = false;
  var list1;
  var categoryNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new SvgPicture.asset(
                        "assets/svg/album.svg",
                        fit: BoxFit.fill,
                        width: 20,
                        height: 20,
                      ),
                      title: new Text('앨범'),
                      onTap: () {
                        _imgFromGallery();
                        FocusManager.instance.primaryFocus!.unfocus();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new SvgPicture.asset(
                      "assets/svg/camera.svg",
                      fit: BoxFit.fill,
                      width: 20,
                      height: 20,
                    ),
                    title: new Text('카메라'),
                    onTap: () {
                      _imgFromCamera();
                      FocusManager.instance.primaryFocus!.unfocus();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile!.path;
    });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) => CupertinoAlertDialog(
    //           title: Text('이미지로 저장하시겠습니까?'),
    //           actions: <Widget>[
    //             CupertinoDialogAction(
    //               child: Text('아니요'),
    //               onPressed: () => Navigator.of(context).pop(),
    //             ),
    //             CupertinoDialogAction(
    //                 child: Text('네'),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 }),
    //           ],
    //         ));
  }

  _imgFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile!.path;
    });
    print("hoit ${imageFile!.path}");
    // showSave();
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) => CupertinoAlertDialog(
    //           title: Text('이미지로 저장하시겠습니까?'),
    //           actions: <Widget>[
    //             CupertinoDialogAction(
    //               child: Text('아니요'),
    //               onPressed: () => Navigator.of(context).pop(),
    //             ),
    //             CupertinoDialogAction(
    //                 child: Text('네'),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 }),
    //           ],
    //         ));
  }

  Widget gridViewCategory() {
    return GridView.count(
        crossAxisCount: 4,
        children: List.generate(8, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: IconButton(
                  iconSize: 22,
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          );
        }));
  }

  void userUpdate() async {
    String urlProfileImageApi;
    if (_image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("profile/${controller.user?.uid}");

      await ref.putFile(File(_image));

      urlProfileImageApi = await ref.getDownloadURL().then((value) {
        var downloadURL = "";
        setState(() {
          downloadURL = value;
        });
        return downloadURL;
      });
    } else {
      urlProfileImageApi = user!.url!;
    }

    if (checking.isNotEmpty) {
      var list = new List.filled(checking.length, 0, growable: false);
      for (int i = 0; i < checking.length; i++) {
        list[i] = checking.keys.elementAt(i);
      }
      if (categoryNumber != checking.length) {
      } else {
        if (_formKey.currentState!.validate() && checking.length > 0) {
          controller.updateUserDatabase(user!, _usernameControl.text,
              urlProfileImageApi, _introductionControl.text, list);
        }
      }
    } else {
      if (_formKey.currentState!.validate()) {
        controller.updateUserDatabase(user!, _usernameControl.text,
            urlProfileImageApi, _introductionControl.text, user!.category);
      }
    }
  }

  Widget selectCategory(categoryList) {
    print(categoryList);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab1",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.lightGreen[500],
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "FRIENDS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab2",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.yellow[600],
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "GROUPS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab3",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.purple[400],
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "NEARBY",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab4",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.blue[400],
                      child: Icon(
                        Icons.near_me,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "MOMENT",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab5",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.indigo[300],
                      child: Icon(
                        Icons.crop_original,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "ALBUMS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab6",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.green[500],
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "LIKES",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab7",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.lightGreen[400],
                      child: Icon(
                        Icons.subject,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "ARTICLES",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab8",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.orange[300],
                      child: Icon(
                        Icons.textsms,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "REVIEWS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<dynamic, bool> checking = new Map();

  Widget changeCategory(list1) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('category').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading"),
            );
          }

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Colors.white,
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: SingleChildScrollView(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, count) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Column(
                                children: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: checking[
                                                      snapshot.data!.docs[count]
                                                          ["categoryId"]] ==
                                                  true
                                              ? BorderSide(
                                                  color: Colors.black, width: 2)
                                              : BorderSide(color: Colors.white),
                                        ),
                                        primary: Colors.white,
                                        elevation: 1),
                                    child: ClipRRect(
                                      child: Image.network(
                                        snapshot.data!.docs[count]
                                            ['categoryImage'],
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        checking[snapshot.data!.docs[count]
                                                        ['categoryId']] ==
                                                    null ||
                                                checking[snapshot
                                                            .data!.docs[count]
                                                        ['categoryId']] ==
                                                    false
                                            ? checking[
                                                snapshot.data!.docs[count]
                                                    ['categoryId']] = true
                                            : checking[
                                                snapshot.data!.docs[count]
                                                    ['categoryId']] = false;

                                        checking
                                            .removeWhere((k, v) => v == false);

                                        if (checking.length > categoryNumber) {
                                          if (checking.length %
                                                  categoryNumber ==
                                              1) {
                                            checking.remove(
                                                checking.entries.first.key);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  Container(height: 5),
                                  Text(
                                    "${snapshot.data!.docs[count]["categoryName"]}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }

  UserModel? user;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                  onTap: userUpdate,
                  child: Image.asset(
                    "assets/icon/userSetting.png",
                    width: 30,
                    height: 30,
                  )),
            ),
          )
        ],
      ),
      body: GetX<UserController>(initState: (_) async {
        Get.find<UserController>().user =
            await UserDatabase().getUser(Get.find<AuthController>().user!.uid);
      }, builder: (snapshot) {
        if (snapshot.user.nickname != null) {
          user = snapshot.user;
          _usernameControl.text = user!.nickname!;

          _introductionControl.text = user!.introduction!;

//          user!.vip == true ? categoryNumber = 6 : categoryNumber = 3;
          categoryNumber = 3;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Column(
                    children: [
                      _image == null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    child: CircleAvatar(
                                      radius: 70.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  size: 16.0,
                                                  color: Color(0xFF404040),
                                                ),
                                                onPressed: () {
                                                  _showPicker(context);
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                },
                                              ),
                                            ),
                                          ),
                                          radius: 70.0,
                                          backgroundImage: NetworkImage(
                                              snapshot.user.url ?? "")),
                                    ),
                                  )),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    child: CircleAvatar(
                                      radius: 70.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 18.0,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  size: 16.0,
                                                  color: Color(0xFF404040),
                                                ),
                                                onPressed: () {
                                                  _showPicker(context);
                                                },
                                              ),
                                            ),
                                          ),
                                          radius: 70.0,
                                          backgroundImage:
                                              FileImage(File(_image))),
                                    ),
                                  )),
                            ),
                      // Image.file(
                      //           File(_image),
                      //           height: 50,
                      //           width: 50,
                      //           fit: BoxFit.contain,
                      //         ),
                      Padding(padding: EdgeInsets.all(20)),
                      Container(
                          height: height * 0.1,
                          width: width * 0.8,
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.grey[900]!, width: 2),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.grey[900]!, width: 1),
                              ),
                            ),
                            validator: (value) {
                              if (value!.length > 0 && value.length < 3) {
                                return "at least 3 words";
                              }
                              _usernameControl.text = value;
                              // _usernameControl.selection = TextSelection(
                              //     baseOffset: _usernameControl.text.length,
                              //     extentOffset: value.length);
                              return null;
                            },
                            controller: _usernameControl,
                            maxLines: 1,
                            cursorColor: Colors.amber[500],
                          )),
                      Container(
                        height: 150,
                        width: width * 0.8,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.amber[500],
                          maxLines: 7,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: Colors.grey[900]!, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: Colors.grey[900]!, width: 1),
                            ),
                          ),
                          controller: _introductionControl,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              _introductionControl.text = value;
                              return null;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30)),

                      Container(
                        height: 50.0,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: categoryButtonClick == true
                                  ? Colors.orange[50]
                                  : Colors.grey[50],
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                categoryButtonClick == true
                                    ? Text("변경 취소",
                                        style: MyText.medium(context).copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300))
                                    : Text("카테고리 변경",
                                        style: MyText.medium(context).copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300)),
                                Spacer(),
                                categoryButtonClick == true
                                    ? Icon(Icons.cancel, color: Colors.black)
                                    : Icon(Icons.arrow_drop_down_rounded,
                                        color: Colors.black),
                                Container(width: 10)
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                categoryButtonClick = !categoryButtonClick;
                                if (categoryButtonClick) {
                                  checking = new Map<dynamic, bool>();
                                  for (int i = 0;
                                      i < user!.category!.length;
                                      i++) {
                                    checking[user!.category![i]] = true;
                                  }
                                }
                                // if (categoryButtonClick) {
                                // } else {
                                //   checking = new Map<dynamic, bool>();
                                //   for (int i = 0;
                                //       i < user!.category!.length;
                                //       i++) {
                                //     checking[user!.category![i]] = true;
                                //   }
                                // }
                              });
                            }),
                      ),
                      categoryButtonClick == true
                          ? Container(
                              height: 220,
                              margin: EdgeInsets.only(top: 20),
                              child: changeCategory(user!.category))
                          : Container(
                              height: 0,
                            ),
                      // Container(
                      //   height: 50.0,
                      //   width: MediaQuery.of(context).size.width * 0.8,
                      //   padding: EdgeInsets.only(left: 30, right: 30),
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         primary: Colors.white,
                      //         onPrimary: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(32.0),
                      //             side: BorderSide(
                      //                 color: Colors.black, width: 1)),
                      //       ),
                      //       child: Text(
                      //         "LOGIN",
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       onPressed: userUpdate),
                      // ),
                      // Stack(
                      //   children: [
                      //     Container(
                      //       height: 200,
                      //       width: width * 0.8,
                      //       child: Card(
                      //           elevation: 2,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20),
                      //             side: BorderSide(
                      //               width: 1,
                      //               color: (Colors.grey[400])!,
                      //             ),
                      //           ),
                      //           child: Container(
                      //               padding: EdgeInsets.only(top: 10),
                      //               alignment: Alignment.center,
                      //               child: gridViewCategory())),
                      //     ),
                      //     Positioned(
                      //       top: -10,
                      //       right: 6,
                      //       child: Container(
                      //         padding:
                      //             EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                      //         decoration: BoxDecoration(
                      //             color: Colors.grey[400],
                      //             borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(8),
                      //               bottomRight: Radius.circular(8),
                      //             ) // green shaped
                      //             ),
                      //         child: Text(
                      //           "Category",
                      //           style: TextStyle(fontSize: 23),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  )
                ])),
          );
        }
        return Center(
          child: Text("loading"),
        );
      }),
    );
  }
}
