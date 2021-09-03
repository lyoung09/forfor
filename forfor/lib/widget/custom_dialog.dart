import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              TextFormField(
                maxLines: 1,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'invite your group',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => SingleChoiceDialog(
                                text: 'Note added',
                              ));
                    },
                    child: Icon(Icons.arrow_forward_ios)),
              ),
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
