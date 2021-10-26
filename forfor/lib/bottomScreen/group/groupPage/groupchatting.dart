import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forfor/adapter/ChattingAdapter.dart';
import 'package:forfor/model/message.dart';
import 'package:forfor/utils/tools.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class GroupChatting extends StatefulWidget {
  final SimpleHiddenDrawerController controller;

  const GroupChatting({Key? key, required this.controller}) : super(key: key);

  @override
  GroupChattingState createState() => new GroupChattingState();
}

class GroupChattingState extends State<GroupChatting> {
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
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.menu),
            onPressed: () {
              widget.controller.toggle();
            }),
        actions: [
          IconButton(
              color: Colors.black,
              icon: Icon(Icons.more_vert),
              onPressed: () {})
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
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
                    onPressed: () {
                      if (showSend) sendMessage();
                    }),
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

  void sendMessage() {
    String message = inputController.text;
    inputController.clear();
    showSend = false;
    setState(() {
      // adapter.insertSingleItem(Message.time(
      //     adapter.getItemCount(),
      //     message,
      //     true,
      //     adapter.getItemCount() % 5 == 0,
      //     Tools.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    });
    generateReply(message);
  }

  void generateReply(String msg) {
    Timer(Duration(seconds: 1), () {
      setState(() {
        // adapter.insertSingleItem(Message.time(
        //     adapter.getItemCount(),
        //     msg,
        //     false,
        //     adapter.getItemCount() % 5 == 0,
        //     Tools.getFormattedTimeEvent(
        //         DateTime.now().millisecondsSinceEpoch)));
      });
    });
  }
}
