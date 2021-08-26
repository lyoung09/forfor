import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _image;
  initState() {
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
                        updateImage();
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
                      updateImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String urlProfileImageApi = "";
  updateImage() async {
    FirebaseStorage.instance
        .ref()
        .child("profile/${auth.currentUser?.uid}")
        .delete();

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profile/${auth.currentUser?.uid}");

    await ref.putFile(File(_image));

    urlProfileImageApi = await ref.getDownloadURL().then((value) {
      var downloadURL = "";
      setState(() {
        downloadURL = value;
      });
      return downloadURL;
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser?.uid)
        .update({"url": urlProfileImageApi});
  }

  deleteUser() async {
    auth.currentUser!.delete();
    Navigator.pushNamed(context, "/login");
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.black,
        toolbarHeight: size.height * 0.06,
        automaticallyImplyLeading: false,
        title: Text(
          "프로필",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          InkWell(
            onTap: deleteUser,
            child: Container(
              child: Text("로그아웃"),
              padding: EdgeInsets.only(
                  left: width * 0.1, right: width * 0.1, bottom: 0.0),
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future:
              firestore.collection('users').doc(auth.currentUser?.uid).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading...");
            }
            print("${snapshot.data!['url']}");
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage('${snapshot.data!['url']}'),
                          ),
                          Positioned(
                            right: -18,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.white),
                                ),
                                color: Color(0xFFF5F6F9),
                                onPressed: () {
                                  _showPicker(context);
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Text(
                    "${snapshot.data!['nickname']}",
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: width * 0.1,
                          height: height * 0.05,
                          child: Text("1")),
                      Container(
                          width: width * 0.1,
                          height: height * 0.05,
                          child: Text("1")),
                      Container(
                          width: width * 0.1,
                          height: height * 0.05,
                          child: Text("1")),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Container(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[800],
                    ),
                    padding: EdgeInsets.only(
                        left: width * 0.1, right: width * 0.1, bottom: 0.0),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                ],
              ),
            );
          }),
    );
  }
}
