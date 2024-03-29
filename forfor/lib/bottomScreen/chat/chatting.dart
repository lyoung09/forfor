import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forfor/adapter/ChattingAdapter.dart';

import 'package:forfor/model/message.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';

class ChatBBMRoute extends StatefulWidget {
  ChatBBMRoute();

  @override
  ChatBBMRouteState createState() => new ChatBBMRouteState();
}

class ChatBBMRouteState extends State<ChatBBMRoute> {
  bool showSend = false;
  final TextEditingController inputController = new TextEditingController();
  List<Message> items = [];
  late ChattingAdapter adapter;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adapter = ChattingAdapter(context, items, onItemClick);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xff0192CC),
          brightness: Brightness.dark,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Jeff",
                  style: MyText.medium(context).copyWith(color: Colors.white)),
              Container(height: 2),
              Text("Traveling today. BBM me.",
                  style:
                      MyText.body1(context)!.copyWith(color: MyColors.grey_10)),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.call), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person_add), onPressed: () {}),
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: adapter.getView(),
            ),
            Divider(height: 0, thickness: 1),
            Row(
              children: <Widget>[
                Container(width: 10),
                Expanded(
                  child: TextField(
                    controller: inputController,
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Write a message...'),
                    onChanged: (term) {
                      setState(() {
                        showSend = (term.length > 0);
                      });
                    },
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.sentiment_satisfied,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.send, color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.crop_original,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.my_location,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.photo_camera,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.insert_drive_file,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: MyColors.grey_40, size: 20),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onItemClick(int index, String obj) {}
}
