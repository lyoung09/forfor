import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forfor/controller/bind/authcontroller.dart';

import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfomation extends StatefulWidget {
  const UserInfomation({Key? key}) : super(key: key);

  @override
  _UserInfomationState createState() => _UserInfomationState();
}

class _UserInfomationState extends State<UserInfomation>
    with WidgetsBindingObserver {
  final TextEditingController _usernameControl = new TextEditingController();
  var _image;
  bool isLoading = true;
  var _country;
  var _countryCode;
  var _birthYear;
  var _gender;

  bool selectCountry = false;
  bool selectKoreanHopeCountry = false;
  bool selectBirth = false;
  final TextEditingController _introductionControl =
      new TextEditingController();
  bool checkNickname = true;
  bool nullCheck = true;
  bool introduceCheck = true;
  List<RadioModel> sampleData = [];
  var userid;
  final controller = Get.put(AuthController());
  @override
  initState() {
    super.initState();
    sampleData.add(new RadioModel(false, '남'));
    sampleData.add(new RadioModel(false, '여'));
    WidgetsBinding.instance!.addObserver(this);
  }

  final FocusNode _nodeText = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText,
        ),
      ],
    );
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.paused == state) {}
    if (AppLifecycleState.detached == state) {
      print("Status :" + state.toString());
      controller.deleteUser();
    }
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
                FocusManager.instance.primaryFocus!.unfocus();
                Navigator.of(context).pop();

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
    final imageFile = await imagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    _file = imageFile != null ? File(imageFile.path) : null;
    _cropImage();
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

  File? _file;

  _cropImage() async {
    var croppedFile = await ImageCropper.cropImage(
        sourcePath: _file!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.orange[50],
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _file = croppedFile;
      setState(() {
        _image = _file!.path;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final _formKey = GlobalKey<FormState>();

  _imgFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    _file = imageFile != null ? File(imageFile.path) : null;
    _cropImage();
  }

  String urlProfileImageApi = "";
  String errorMessage = "";
  bool checknull() {
    if (_usernameControl.text.isEmpty ||
        _gender.toString().isEmpty ||
        _image == null ||
        _countryCode.toString().isEmpty ||
        _usernameControl.text.length < 3 ||
        _introductionControl.toString().isEmpty) {
      return true;
    }
    return false;
  }

  void userInfomationSave() async {
    _usernameControl.text.isEmpty || _usernameControl.text.length < 3
        ? setState(() {
            checkNickname = false;
          })
        : setState(() {
            checkNickname = true;
          });

    if (checknull()) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                content: Text("Check one more time please."),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('no empty'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    } else {
      setState(() {
        isLoading = false;
      });
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

      controller.addUserInformation(
        _gender.toString(),
        _countryCode.toLowerCase(),
        _usernameControl.text,
        urlProfileImageApi,
        _introductionControl.text,
      );
      setState(() {
        isLoading = true;
      });
    }
  }

  bool koreanSelected = false;
  bool notKoreanSelected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Colors.orange[50],
            automaticallyImplyLeading: false,
            title: Text(
              "user infomation",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: isLoading == false
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.orange[200],
              ))
            : KeyboardActions(
                config: _buildConfig(context),
                child: ListView(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 50)),
                          Container(
                              height: height * 0.2,
                              width: height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                  FocusManager.instance.primaryFocus!.unfocus();
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
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                          size: 50,
                                        ),
                                      ),
                              )),
                          Padding(padding: EdgeInsets.only(top: 45)),

                          Container(
                              height: 80,
                              width: width * 0.85,
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.all(10.0),

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: "nickname",
                                  // prefixIcon: Icon(
                                  //   Icons.mail_outline,
                                  //   color: Colors.black,
                                  // ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                controller: _usernameControl,
                                maxLines: 1,
                              )),
                          checkNickname
                              ? Container(
                                  height: 0,
                                )
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.09, top: 3),
                                    child: Text("at least 3 characters",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.red,
                                        )),
                                  ),
                                ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Container(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                            padding: EdgeInsets.only(
                                left: width * 0.1,
                                right: width * 0.1,
                                bottom: 0.0),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Container(
                          //       width: width * 0.2,
                          //       child: Image.asset(
                          //         "assets/icon/citizenship.png",
                          //         height: 35.0,
                          //         width: 35,
                          //       ),
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment
                          //           .center, //Center Row contents horizontally,,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Container(
                          //           alignment: Alignment.center,
                          //           margin: EdgeInsets.only(top: 10, bottom: 10),
                          //           child: ChoiceChip(
                          //             label: Text("korean"),
                          //             selected: koreanSelected,
                          //             onSelected: (bool value) {
                          //               setState(() {
                          //                 koreanSelected = value;
                          //               });

                          //               //Do whatever you want when the chip is selected
                          //             },
                          //             backgroundColor: Colors.transparent,
                          //             selectedColor: Colors.transparent,
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: width * 0.1,
                          //         ),
                          //         Container(
                          //           alignment: Alignment.center,
                          //           margin: EdgeInsets.only(top: 10, bottom: 10),
                          //           child: ChoiceChip(
                          //             label: Text("not korean"),
                          //             selected: notKoreanSelected,
                          //             onSelected: (bool value) {
                          //               notKoreanSelected = value;
                          //               setState(() {
                          //                 notKoreanSelected = value;
                          //               });
                          //             },
                          //             backgroundColor: Colors.transparent,
                          //             selectedColor: Colors.transparent,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // notKoreanSelected == false
                          //     ? Container(
                          //         // height: height * 0.1,
                          //         width: width * 0.8,
                          //         height: 0,
                          //         child: Text(""))
                          //     : Container(
                          //         // height: height * 0.1,
                          //         width: width * 0.8,
                          //         child: Row(
                          //           children: [
                          //             CountryListPick(
                          //                 theme: CountryTheme(
                          //                   isShowFlag: true,
                          //                   isShowTitle: false,
                          //                   isShowCode: false,
                          //                   isDownIcon: true,
                          //                   showEnglishName: true,
                          //                 ),
                          //                 onChanged: (CountryCode? code) {
                          //                   setState(() {
                          //                     _countryCode = code?.dialCode;
                          //                     selectCountry = true;
                          //                     _country = code?.name;
                          //                   });
                          //                 },
                          //                 useUiOverlay: true,
                          //                 // Whether the country list should be wrapped in a SafeArea
                          //                 useSafeArea: false),
                          //             Padding(
                          //                 padding:
                          //                     EdgeInsets.only(right: width * 0.05)),
                          //             selectCountry == true
                          //                 ? Text(
                          //                     _country.length > 20
                          //                         ? ' ${_country.substring(0, 20)}...'
                          //                         : _country,
                          //                     style: TextStyle(
                          //                         color: Colors.black, fontSize: 15))
                          //                 : Text("your country",
                          //                     style: TextStyle(
                          //                         color: Colors.grey[400],
                          //                         fontSize: 15)),
                          //           ],
                          //         )),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Image.asset(
                                    "assets/icon/citizenship.png",
                                    height: 35.0,
                                    width: 35,
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  alignment: Alignment.centerRight,
                                  child: CountryListPick(
                                      theme: CountryTheme(
                                        isShowFlag: true,
                                        isShowTitle: false,
                                        isShowCode: false,
                                        isDownIcon: true,
                                        showEnglishName: true,
                                      ),
                                      onChanged: (CountryCode? code) {
                                        setState(() {
                                          _countryCode = code?.code;

                                          selectCountry = true;
                                        });
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                      useUiOverlay: true,
                                      // Whether the country list should be wrapped in a SafeArea
                                      useSafeArea: false),
                                )
                              ]),
                          Container(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                            padding: EdgeInsets.only(
                                left: width * 0.1,
                                right: width * 0.1,
                                bottom: 0.0),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width * 0.2,
                                child: Image.asset(
                                  "assets/icon/gender.png",
                                  height: 35.0,
                                  width: 35,
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.4,
                                alignment: Alignment.center,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sampleData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (_gender ==
                                        sampleData[index].buttonText) {
                                      sampleData[index].isSelected = true;
                                      return new InkWell(
                                        //highlightColor: Colors.red,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            sampleData.forEach((element) =>
                                                element.isSelected = false);
                                            sampleData[index].isSelected = true;
                                            print(sampleData[index].buttonText);
                                            _gender =
                                                sampleData[index].buttonText;
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
                                          sampleData.forEach((element) =>
                                              element.isSelected = false);
                                          sampleData[index].isSelected = true;
                                          print(sampleData[index].buttonText);
                                          _gender =
                                              sampleData[index].buttonText;
                                        });
                                      },
                                      child: new RadioItem(sampleData[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                            padding: EdgeInsets.only(
                                left: width * 0.1,
                                right: width * 0.1,
                                bottom: 0.0),
                          ),

                          Padding(padding: EdgeInsets.only(top: height * 0.02)),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: width * 0.8,
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Colors.amber[500],
                                maxLines: 3,
                                maxLength: 100,
                                focusNode: _nodeText,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                  labelText: "introduce",
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
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Colors.black)),
                                child: IconButton(
                                  icon: Icon(Icons.navigate_next_rounded),
                                  iconSize: 45,
                                  onPressed: userInfomationSave,
                                ),
                                margin: EdgeInsets.only(right: 30),
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          // Container(
                          //   height: 50.0,
                          //   margin: EdgeInsets.all(10),
                          //   child: RaisedButton(
                          //     onPressed: userInfomationSave,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(80.0)),
                          //     padding: EdgeInsets.all(0.0),
                          //     child: Ink(
                          //       decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                          //             begin: Alignment.centerLeft,
                          //             end: Alignment.centerRight,
                          //           ),
                          //           borderRadius: BorderRadius.circular(30.0)),
                          //       child: Container(
                          //         constraints:
                          //             BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                          //         alignment: Alignment.center,
                          //         child: Text(
                          //           "Continue",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(color: Colors.white, fontSize: 15),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
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
              color: _item.isSelected ? Colors.orange[50] : Colors.transparent,
              border: new Border.all(
                  width: _item.isSelected ? 2.0 : 1.0,
                  color: _item.isSelected ? Colors.orange[300]! : Colors.grey),
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
