import 'dart:ui';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'img.dart';
import 'my_colors.dart';
import 'my_strings.dart';
import 'my_text.dart';

class FcmMessage extends StatefulWidget {
  final String title;
  const FcmMessage({Key? key, required this.title}) : super(key: key);

  @override
  _FcmMessageState createState() => _FcmMessageState();
}

class _FcmMessageState extends State<FcmMessage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ListTile(title: Text(widget.title)),
    );
  }
}

class CustomDialogBox extends StatefulWidget {
  final String title, text;
  final List<dynamic> descriptions;
  final String img;

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
    final List<int> category = widget.descriptions.cast<int>();

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 90,
                      width: 100,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, bottom: 3, top: 20),
                          child: ClipRRect(
                            child: Image.network(
                              widget.img,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("category")
                                    .where("categoryId", whereIn: [
                                  for (int i = 0; i < category.length; i++)
                                    category[i]
                                  // 1,
                                  // 2,
                                  // 3,
                                  // 4,
                                  // 5,
                                ]).get(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> categoryData) {
                                  if (categoryData.hasData) {
                                    print(category.length);
                                    return GridView.builder(
                                        gridDelegate: category.length != 3
                                            ? SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 1 / 0.5)
                                            : SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 1 / 0.75),
                                        shrinkWrap: false,
                                        itemCount: categoryData.data!.size,
                                        itemBuilder: (context, count) {
                                          return InkWell(
                                            onTap: () {
                                              print(categoryData.data!
                                                  .docs[count]["categoryId"]);
                                            },
                                            child: Card(
                                              color: Colors.orange[50],
                                              elevation: 4.0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: CircleAvatar(
                                                  radius: 17,
                                                  backgroundColor:
                                                      Colors.orange[50],
                                                  child: Image.network(
                                                      categoryData
                                                              .data!.docs[count]
                                                          ['categoryImage']),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  return Text("");
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                  Center(
                    child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icon/buddy.png',
                              width: 35,
                              height: 30,
                            ),
                            Text("buddy", style: TextStyle(fontSize: 20)),
                          ],
                        )),
                  ),
                  Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return InviteGroupDialog(
                                text: "Yes",
                              );
                            });
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icon/invite.png',
                            width: 35,
                            height: 30,
                          ),
                          Text(
                            "inviting",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 3),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
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

class CustomCongratDialog extends StatefulWidget {
  CustomCongratDialog({Key? key}) : super(key: key);

  @override
  CustomCongratDialogState createState() => new CustomCongratDialogState();
}

class CustomCongratDialogState extends State<CustomCongratDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text("인증 완료!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.blueAccent[50],
                  child: Column(
                    children: <Widget>[
                      Text("확인",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomEventDialog extends StatefulWidget {
  CustomEventDialog({Key? key}) : super(key: key);

  @override
  CustomEventDialogState createState() => new CustomEventDialogState();
}

class CustomEventDialogState extends State<CustomEventDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.orange[100],
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(Icons.domain_verification_rounded,
                        color: Colors.grey[900], size: 80),
                    Container(height: 10),
                    Text("Group confirmed!",
                        style: MyText.title(context)!
                            .copyWith(color: Colors.grey[900])),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.grey[50],
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        elevation: 0,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0)),
                      ),
                      child: Text("Get Started",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
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

class GroupQuestion extends StatefulWidget {
  GroupQuestion({Key? key}) : super(key: key);

  @override
  GroupQuestionState createState() => new GroupQuestionState();
}

class GroupQuestionState extends State<GroupQuestion> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _questionController = TextEditingController();

  Widget dialogContent(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(
              8.0,
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 5)),
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
                    maxLines: 12,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(border: Border.all()),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
