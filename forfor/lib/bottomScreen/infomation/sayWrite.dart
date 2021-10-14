import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/widget/loading.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int category = 0;
  saveposting() async {
    print(_storycontroller.text);
    if (_storycontroller.text.isEmpty) {
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
        "story": _storycontroller.text,
        "authorId": widget.uid,
        "timestamp": myDateTime,
        "address": address ?? "",
        "count": 0,
        "replyCount": 0,
        "likes": [],
        "category": category,
      });
      Get.back();
    }
  }

  String? address;
  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final controller = Get.put(AuthController());
    late LocationData _currentPosition;
    final Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {

    address = await controller.saveLocation(controller.user!.uid,
        _currentPosition.latitude ?? -1, _currentPosition.longitude ?? -1);
  }

  Widget bottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(color: Colors.orange[50]),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 30)),
            Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                  )),
            ),
            Padding(padding: EdgeInsets.only(right: 15)),
            InkWell(
              child: IconButton(
                icon: Image.asset(
                  'assets/icon/location.png',
                  width: 20.0,
                  height: 20.0,
                ),
                onPressed: () {},
              ),
              onTap: getLoc,
            ),
            Padding(padding: EdgeInsets.only(right: 15)),
            InkWell(
              child: Image.asset(
                'assets/icon/list.png',
                width: 20.0,
                height: 20.0,
              ),
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
                              stream: FirebaseFirestore.instance
                                  .collection('category')
                                  .orderBy("categoryId")
                                  .snapshots(),
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
                                            backgroundColor: category ==
                                                    snapshot.data!.docs[index]
                                                        ["categoryId"]
                                                ? Colors.orange[50]
                                                : Colors.white,
                                            radius: 20,
                                            child: Image.network(
                                              snapshot.data!.docs[index]
                                                  ["categoryImage"],
                                              width: 20,
                                              height: 20,
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
              onPressed: saveposting,
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
                  maxLines: 15,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText:
                        'You can ask anything.\n But do not sexual and political and religious asking!',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 1),
                    ),
                  ),
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
}
