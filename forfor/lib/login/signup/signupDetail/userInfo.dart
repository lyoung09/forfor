import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfomation extends StatefulWidget {
  const UserInfomation({Key? key}) : super(key: key);

  @override
  _UserInfomationState createState() => _UserInfomationState();
}

class _UserInfomationState extends State<UserInfomation> {
  final TextEditingController _usernameControl = new TextEditingController();
  var _image;

  var _country;
  var _birthYear;
  var _gender;

  bool selectCountry = false;
  bool selectBirth = false;

  List<RadioModel> sampleData = [];
  var userid;
  initState() {
    super.initState();
    sampleData.add(new RadioModel(false, '남'));
    sampleData.add(new RadioModel(false, '여'));

    useridMethod();
  }

  useridMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("uid");
    });
  }

  _pickDateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Birth Year"),
          content: Container(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                setState(() {
                  selectBirth = true;
                  _birthYear = dateTime.year;
                });
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    );
  }

  Widget getWidget(bool showOtherGender, bool alignVertical) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,

        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Male,
        selectedGenderTextStyle:
            TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
          _gender = gender;
        },
        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 40, //default : 40
      ),
    );
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

  String urlProfileImageApi = "";
  void userInfomationSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userid = prefs.getString("uid");
    });

    Reference ref = FirebaseStorage.instance.ref().child("profile/${userid}");
    await ref.putFile(File(_image));

    urlProfileImageApi = await ref.getDownloadURL().then((value) {
      var downloadURL = "";
      setState(() {
        downloadURL = value;
      });
      return downloadURL;
    });

    await FirebaseFirestore.instance.collection("users").doc(userid).update({
      "gender": _gender.toString(),
      "country": _country.toString(),
      "nickname": _usernameControl.text,
      "url": urlProfileImageApi
    });

    Navigator.pushNamed(context, '/bottomScreen');
    //Navigator.pushNamed(context, '/hopeInformation');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.06,
          centerTitle: true,
          // backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "my infomation",
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: height * 0.08)),
                Container(
                    height: height * 0.2,
                    width: height * 0.2,
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
                Padding(padding: EdgeInsets.only(top: height * 0.05)),
                Container(
                    height: height * 0.1,
                    width: width * 0.75,
                    child: TextField(
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5.0),
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),

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

                // Padding(padding: EdgeInsets.only(top: height * 0.02)),
                Container(
                    // height: height * 0.1,
                    width: width * 0.8,
                    child: Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/svg/calender.svg",
                            fit: BoxFit.fill,
                            width: 25,
                            height: 25,
                          ),
                          onPressed: _pickDateDialog,
                        ),
                        Padding(padding: EdgeInsets.only(right: width * 0.1)),
                        selectBirth == true
                            ? Text(_birthYear.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15))
                            : Text("Age",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 15)),
                      ],
                    )),
                Container(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[800],
                  ),
                  padding: EdgeInsets.only(
                      left: width * 0.1, right: width * 0.1, bottom: 0.0),
                ),
                Container(
                    // height: height * 0.1,
                    width: width * 0.8,
                    child: Row(
                      children: [
                        CountryListPick(
                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: false,
                              isShowCode: false,
                              isDownIcon: true,
                              showEnglishName: true,
                            ),
                            // initialSelection: '+82',
                            onChanged: (CountryCode? code) {
                              print(code?.name);
                              setState(() {
                                selectCountry = true;
                                _country = code?.name;
                              });
                            },
                            useUiOverlay: true,
                            // Whether the country list should be wrapped in a SafeArea
                            useSafeArea: false),
                        Padding(padding: EdgeInsets.only(right: width * 0.05)),
                        selectCountry == true
                            ? Text(
                                _country.length > 30
                                    ? _country.substring(0, 30)
                                    : _country,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15))
                            : Text("country",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 15)),
                      ],
                    )),
                Container(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[800],
                  ),
                  padding: EdgeInsets.only(
                      left: width * 0.1, right: width * 0.1, bottom: 0.0),
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: width * 0.06)),
                    Container(
                      width: width * 0.2,
                      child: Image.asset(
                        "assets/icon/gender.png",
                        height: 35.0,
                        width: 35,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: width * 0.08)),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sampleData.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_gender == sampleData[index].buttonText) {
                            sampleData[index].isSelected = true;
                            return new InkWell(
                              //highlightColor: Colors.red,
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  sampleData.forEach(
                                      (element) => element.isSelected = false);
                                  sampleData[index].isSelected = true;
                                  print(sampleData[index].buttonText);
                                  _gender = sampleData[index].buttonText;
                                });
                              },
                              child: new RadioItem(sampleData[index]),
                            );
                          }
                          return new InkWell(
                            //highlightColor: Colors.red,
                            splashColor: Colors.blueAccent,
                            onTap: () {
                              setState(() {
                                sampleData.forEach(
                                    (element) => element.isSelected = false);
                                sampleData[index].isSelected = true;
                                print(sampleData[index].buttonText);
                                _gender = sampleData[index].buttonText;
                              });
                            },
                            child: new RadioItem(sampleData[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.06),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: userInfomationSave,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              // color: _item.isSelected ? Colors.black : Colors.transparent,
              border: new Border.all(
                  width: _item.isSelected ? 2.0 : 1.0,
                  color: _item.isSelected ? Colors.black : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
