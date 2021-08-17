import 'dart:io';

import 'package:flutter/material.dart';

class HopeInfomation extends StatefulWidget {
  const HopeInfomation({Key? key}) : super(key: key);

  @override
  _HopeInfomationState createState() => _HopeInfomationState();
}

class _HopeInfomationState extends State<HopeInfomation> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: height * 0.15)),
                Align(
                    alignment: Alignment.center,
                    child: Text("Want to know country")),
                Container(
                  child: Divider(
                    thickness: 2.5,
                    color: Colors.blue[800],
                  ),
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                ),
                Padding(padding: EdgeInsets.only(top: height * 0.2)),
                Image.file(
                  File(
                      "https://firebasestorage.googleapis.com/v0/b/forforw2m.appspot.com/o/profile%2FcicG8sZSdpPNFbDcBDSYndrEOzl2?alt=media&token=344bea49-6ea4-491b-a3a7-7ea8fd84cf39"),
                  width: 20,
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Image.file(File(
                              "https://firebasestorage.googleapis.com/v0/b/forforw2m.appspot.com/o/profile%2FcicG8sZSdpPNFbDcBDSYndrEOzl2?alt=media&token=344bea49-6ea4-491b-a3a7-7ea8fd84cf39")),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: height * 0.15)),
                Row(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: height * 0.15)),
                Row(
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      height: height * 0.15,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.ac_unit),
                          Text("hello"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
