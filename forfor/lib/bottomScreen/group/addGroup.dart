import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:flutter/material.dart';
import 'package:forfor/widget/my_text.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget privateOrNot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'unlock';
                  id = 1;
                });
              },
            ),
            Text(
              '공개',
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(right: 20)),
        Column(
          children: [
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'lock';
                  id = 2;
                });
              },
            ),
            Text(
              '비공개',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectCategory() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      CustomCheckBoxGroup(
        buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.red,
          unSelectedColor: Colors.orange,
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
        unSelectedColor: Theme.of(context).canvasColor,
        buttonLables: [
          "M",
          "T",
          "W",
          "T",
          "F",
          "S",
          "S",
        ],
        buttonValuesList: [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        ],
        checkBoxButtonValues: (values) {
          print(values);
        },
        spacing: 0,
        defaultSelected: null,
        horizontal: false,
        enableButtonWrap: false,
        width: 40,
        absoluteZeroSpacing: false,
        selectedColor: Theme.of(context).accentColor,
        padding: 10,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[400],
          title: Text("그룹 만들기", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 100,
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
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                    width: 80,
                    height: 100,
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
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                    width: 80,
                    height: 100,
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
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  maxLines: 1,
                  style: MyText.subhead(context)!.copyWith(color: Colors.black),
                  controller: new TextEditingController(text: ""),
                  decoration: InputDecoration(
                      hintText: "방제",
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                height: 160,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.amber[500],
                  maxLines: 30,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle:
                        MyText.body1(context)!.copyWith(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.amber[500]!, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              privateOrNot(),
              Container(
                child: Divider(
                  thickness: 1.8,
                ),
              ),
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(
                              25.0) //                 <--- border radius here
                          ),
                    ),
                    child: Text("category verlfodododoodod"),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                    ),
                    child: Text("hoit"),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                    ),
                    child: Text("hoit"),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                ],
              ),
            ],
          ),
        ));
  }

  bool _selected = false;
  bool s1 = false;
  bool s2 = false;
}
