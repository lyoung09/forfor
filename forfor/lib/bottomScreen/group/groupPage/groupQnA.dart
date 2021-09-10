import 'package:flutter/material.dart';
import 'package:forfor/widget/circle_image.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class GroupQnA extends StatefulWidget {
  final SimpleHiddenDrawerController controller;
  const GroupQnA({Key? key, required this.controller}) : super(key: key);

  @override
  _GroupQnAState createState() => _GroupQnAState();
}

class _GroupQnAState extends State<GroupQnA> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _questionController = TextEditingController();

  writingQnA() {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      print(_titleController.text);
                      print(_questionController.text);
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ),
              ],
            ),
            content: Container(
              height: 300,
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "title",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[900]!, width: 0.5),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Expanded(
                    child: TextField(
                      controller: _questionController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "question",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900]!, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[900]!, width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    print(_titleController.text);
                    print(_questionController.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
      widget.controller.dispose();
    }
  }

  writeQuestion() {
    showDialog(
        context: context, builder: (BuildContext context) => GroupQuestion());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.menu),
              onPressed: () {
                widget.controller.toggle();
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: writeQuestion,
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 115),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.lightGreen[400],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Taylor W ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("posted a",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                      Container(width: 3),
                                      Text("Note",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("Just now",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                          Container(height: 10),
                          Text(MyStrings.middle_lorem_ipsum,
                              style: MyText.caption(context)!
                                  .copyWith(color: Colors.grey[600]))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 64),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 29, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.lightBlue[400],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("C. Northrop ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("is now following you ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("22 minutes ago",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 64),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 29, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.lightBlue[400],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Nathaniel ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("is now following you ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("22 minutes ago",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 215),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.red[400],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Taylor W ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("posted a",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                      Container(width: 3),
                                      Text("Photo",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("Just now",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                          Container(height: 10),
                          Image.asset(
                            'assets/image/photo_female_1.jpg',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 64),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 29, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.amber[500],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Lillie Hoyos ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("in ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                      Text("Bangkok, Thailand",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("08.30 am yesterday",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 155),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.lightGreen[400],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Homer J. Allen ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("posted a",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                      Container(width: 3),
                                      Text("Note",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("10.15 am yesterday",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                          Container(height: 10),
                          Text(MyStrings.lorem_ipsum,
                              style: MyText.caption(context)!
                                  .copyWith(color: Colors.grey[600]))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 10),
                Container(
                  alignment: Alignment.center,
                  width: 20,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(width: 1, color: Colors.grey[300], height: 64),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 29, 0, 0),
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.amber[500],
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleImage(
                                imageProvider: AssetImage(
                                    'assets/image/photo_female_1.jpg'),
                                size: 35,
                              ),
                              Container(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Lillie Hoyos ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                      Text("in ",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.grey[500])),
                                      Text("Jiangsu, China",
                                          style: MyText.caption(context)!
                                              .copyWith(
                                                  color: Colors.lightBlue[400],
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Container(height: 5),
                                  Text("2 days ago",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[400])),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
