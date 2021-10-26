import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/widget/loading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class SayWriting extends StatefulWidget {
  final String uid;
  const SayWriting({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _SayWritingState createState() => _SayWritingState();
}

class _SayWritingState extends State<SayWriting> {
  TextEditingController _storycontroller = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageList = [];
  List<Asset> imageList = [];

  List<File> writePicList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CollectionReference _ref = FirebaseFirestore.instance.collection('category');
  int category = 0;
  saveposting() async {
    if (_storycontroller.text.isEmpty && writePicList.isEmpty) {
      Get.defaultDialog(
        title: "Error",
        middleText: "사진 또는 글이 있어야합니다",
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        onCancel: () {
          FocusScope.of(context).requestFocus(new FocusNode());

          // Get.back();
        },
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );
    } else {
      DateTime currentPhoneDate = DateTime.now(); //DateTime

      Timestamp myTimeStamp =
          Timestamp.fromDate(currentPhoneDate); //To TimeStamp

      DateTime myDateTime = myTimeStamp.toDate(); //

      await FirebaseFirestore.instance.collection('posting').add({
        "story": _storycontroller.text.isEmpty ? "" : _storycontroller.text,
        "authorId": widget.uid,
        "timestamp": myDateTime,
        "count": 0,
        "save": [],
        "replyCount": 0,
        "category": category,
        "images": []
      }).then((value) async {
        if (writePicList.isEmpty) {
          FirebaseFirestore.instance
              .collection('posting')
              .doc(value.id)
              .update({"postingId": value.id});
          Get.back();
        } else {
          Get.dialog(Loading());

          for (int i = 0; i < writePicList.length; i++) {
            //List<File> jpegPath = [];
            // Platform.isIOS
            //     ? jpegPath.add(await HeicToJpg.convert(writePicList[i]))
            //     : print("");

            Reference ref = FirebaseStorage.instance
                .ref()
                .child('posting/${value.id}/${i}');

            await ref.putFile(writePicList[i]).whenComplete(() async {
              print(writePicList[i]);
              print(value.id);
              await ref.getDownloadURL().then((url) {
                print(url);
                FirebaseFirestore.instance
                    .collection('posting')
                    .doc(value.id)
                    .update({
                  "postingId": value.id,
                  "images": FieldValue.arrayUnion([url])
                });
              });
            });
          }
          Get.to(() => BottomNavigation(index: 3));
        }
      });
    }
  }

  showDia(context) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              content: Text("사진은 최대 6장입니다."),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('check'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }

  Widget bottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.orange[50]),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 30)),
            Container(
              child: IconButton(
                  onPressed: () {
                    writePicList.length >= 6
                        ? showDia(context)
                        : showModal(context);
                    //loadAssets();
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                  )),
            ),

            Padding(padding: EdgeInsets.only(right: 15)),
            InkWell(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      _ref.where("categoryId", isEqualTo: category).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Image.network(
                        //'assets/icon/all.png',
                        snapshot.data!.docs[0]["categoryImage"],
                        width: 20.0,
                        height: 20.0,
                      ),
                    );
                  }),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                          height: 180,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Colors.white,
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _ref.orderBy("categoryId").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }
                                return GridView.builder(
                                    itemCount: snapshot.data!.size,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 2,
                                            crossAxisCount: 4),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            category = snapshot.data!
                                                .docs[index]["categoryId"];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange[50],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  border: category ==
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ["categoryId"]
                                                      ? Border.all(
                                                          width: 1,
                                                          color: Colors.black)
                                                      : Border.all(
                                                          width: 0,
                                                          color: Colors.white)),
                                              child: Image.network(
                                                snapshot.data!.docs[index]
                                                    ["categoryImage"],
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      );
                    });
              },
            ),
            Spacer(),
            InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                child: Text("Done"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            )
            //IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(color: Colors.black, height: 1.4, fontSize: 16);

    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[400],
          title: Text("Question",
              style: TextStyle(color: Colors.grey[900], fontSize: 25)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 25,
              color: Colors.grey[900],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.send_outlined,
                size: 25,
                color: Colors.grey[900],
              ),
              onPressed: () {
                saveposting();
              },
            ),
          ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 20),
                TextFormField(
                  style: textStyle,
                  controller: _storycontroller,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      _storycontroller.text = value;
                      return null;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black26,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText:
                        'You can ask anything.\n But do not sexual and political and religious asking!',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  child: GridView.builder(
                      shrinkWrap: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: writePicList.length,
                      itemBuilder: (BuildContext context, count) {
                        return Stack(
                          children: [
                            
                            Center(
                              child: Image.file(writePicList[count],
                                  width: 100, height: 100, fit: BoxFit.cover),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                  onPressed: () {
                                    writePicList.removeAt(count);

                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey[200],
                                    size: 20,
                                  )),
                            )
                          ],
                        );
                      }),
                ),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: bottom(),
    );
  }

  showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_rounded),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text('CAMERA'),
                  ],
                ),
                onTap: () {
                  imageCameraSelect();

                  Navigator.pop(context);
                },
              ),
              ListTile(
                //leading: Icon(Icons.alarm_add_rounded),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo),
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text('ALBUM'),
                  ],
                ),
                onTap: () {
                  loadAssets();

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Center(
                    child:
                        Text('취소', style: TextStyle(color: Colors.grey[600]))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void imageCameraSelect() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (writePicList.length >= 6 || imageList.length + _imageList.length >= 6) {
    } else {
      // FocusScope.of(context).requestFocus(new FocusNode());

      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.camera);

      if (selectedImage!.path.isNotEmpty) {
        writePicList.add(File(selectedImage.path));
        _imageList.add(selectedImage);
      }
      setState(() {});
    }
  }

  void loadAssets() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (writePicList.length >= 6) {
    } else {
      List<Asset> resultList = <Asset>[];
      String error = 'No Error Detected';

      try {
        int z = 6 - writePicList.length;
        resultList = await MultiImagePicker.pickImages(
          maxImages: z,
          enableCamera: true,
          selectedAssets: imageList,
          cupertinoOptions: CupertinoOptions(doneButtonTitle: "${z}장 남음"),
        );
      } on Exception catch (e) {
        error = e.toString();
        print(error);
      }
      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.

      setState(() {
        imageList = resultList;
      });

      resultList.forEach((imageAsset) async {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          writePicList.add(tempFile);
        }

        setState(() {});
      });
      resultList.clear();
    }
  }
}
