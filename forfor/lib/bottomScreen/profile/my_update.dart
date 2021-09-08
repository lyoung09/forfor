import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UserUpdate extends StatefulWidget {
  const UserUpdate({Key? key}) : super(key: key);

  @override
  _UserUpdateState createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  var _image;
  final TextEditingController _usernameControl = new TextEditingController();
  bool checkNickname = true;
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
        actions: [],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: _image != null
                              ? Image.file(
                                  File(_image),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                    size: 50,
                                  ),
                                ),
                        )),
                    Padding(padding: EdgeInsets.all(20)),
                    Container(
                        height: height * 0.1,
                        width: width * 0.8,
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.all(10.0),

                            errorText:
                                checkNickname ? null : "at least 3 characters",
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.white,
                            //   ),
                            //   borderRadius: BorderRadius.circular(5.0),
                            // ),
                            hintText: "   nickname",
                            // prefixIcon: Icon(
                            //   Icons.mail_outline,
                            //   color: Colors.black,
                            // ),
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[400],
                            ),
                          ),
                          controller: _usernameControl,
                          maxLines: 1,
                        )),
                    Padding(padding: EdgeInsets.all(20)),
                    Card(
                      elevation: 3,
                      child: Container(
                          child: Column(
                        children: [
                          Text("Change category"),
                          Divider(
                            thickness: 1.4,
                            color: Colors.grey[400],
                          ),
                          Wrap(
                            children: [Text("1")],
                          ),
                        ],
                      )),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                  ],
                ))
          ])),
    );
  }
}
