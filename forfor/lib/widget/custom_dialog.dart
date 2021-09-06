import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'img.dart';
import 'my_strings.dart';
import 'my_text.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
      required this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 20, top: 45 + 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.ac_unit, size: 25)),
                      Text("buddy", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return InviteGroupDialog(
                                    text: "Yes",
                                  );
                                });
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) {
                            //       return InviteGroupDialog(text: widget.title);
                            //     },
                            //   ),
                            // );
                          },
                          icon: Icon(
                            Icons.ac_unit,
                            size: 25,
                          )),
                      Text(
                        "inviting",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: widget.img),
          ),
        ),
      ],
    );
  }
}

class SingleChoiceDialog extends StatefulWidget {
  final String text;
  SingleChoiceDialog({Key? key, required this.text}) : super(key: key);

  @override
  SingleChoiceDialogState createState() => new SingleChoiceDialogState();
}

class SingleChoiceDialogState extends State<SingleChoiceDialog> {
  String? selectedRingtone = "None";

  List<String> ringtone = [
    "NoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNone",
    "korean",
    "englist",
    "Luna"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Group List"),
      content: Wrap(
        children: ringtone
            .map((r) => RadioListTile(
                  activeColor: Colors.black,
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/icon/email.png',
                        width: 30,
                        height: 30,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Expanded(
                        child: Text(
                          r,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  groupValue: selectedRingtone,
                  selected: r == selectedRingtone,
                  value: r,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedRingtone = val;
                    });
                  },
                ))
            .toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class InviteGroupDialog extends StatefulWidget {
  final String text;

  const InviteGroupDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _InviteGroupDialogState createState() => _InviteGroupDialogState();
}

class _InviteGroupDialogState extends State<InviteGroupDialog>
    with TickerProviderStateMixin {
  String? selectedRingtone =
      "NoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNone";
  List<String> ringtone = [
    "NoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNoneNone",
    "korean",
    "englist",
    "Luna"
  ];
  String? groupTitle;
  late AnimationController controller2;
  bool expand2 = false;
  late Animation<double> animation2, animation2View;

  initState() {
    super.initState();

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    animation2 = Tween(begin: 0.0, end: 180.0).animate(controller2);
    animation2View = CurvedAnimation(parent: controller2, curve: Curves.linear);

    controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }

  void togglePanel2() {
    if (!expand2) {
      controller2.forward();
    } else {
      controller2.reverse();
    }
    expand2 = !expand2;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text("study english together",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Spacer(flex: 1),
                Transform.rotate(
                  angle: animation2.value * math.pi / 180,
                  child: IconButton(
                    icon: Icon(Icons.expand_more),
                    onPressed: () {
                      togglePanel2();
                    },
                  ),
                )
              ],
            ),
            SizeTransition(
              sizeFactor: animation2View,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("group2"),
                      Container(width: 10),
                      Radio(
                        value: "group2",
                        groupValue: groupTitle,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (String? value) {
                          setState(() {
                            groupTitle = value;
                          });
                          togglePanel2();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("group3"),
                      Container(width: 10),
                      Radio(
                        value: "group3",
                        groupValue: groupTitle,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (String? value) {
                          setState(() {
                            groupTitle = value;
                          });
                          togglePanel2();
                        },
                      ),
                    ],
                  ),
                  Divider(height: 0, thickness: 0.5),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Wrap(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/image/photo_female_1.jpg',
                            fit: BoxFit.cover)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(height: 10),
                        Container(
                          decoration: BoxDecoration(border: Border.all()),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            maxLines: 1,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Join my group',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: (Colors.blue[400])!),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("send")),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: (Colors.red[400])!),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("cancel")),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
