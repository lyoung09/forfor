import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class EmojiPickerDemo extends StatefulWidget {
  @override
  _EmojiPickerDemoState createState() => _EmojiPickerDemoState();
}

class _EmojiPickerDemoState extends State<EmojiPickerDemo> {
  late bool isShowSticker;

  @override
  void initState() {
    super.initState();
    isShowSticker = false;
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emoji Picker Demo"),
      ),
      body: WillPopScope(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // Button send image
                        Material(
                          child: new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 1.0),
                            child: new IconButton(
                              icon: new Icon(Icons.image),
                              onPressed: () {},
                              color: Colors.blueGrey,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        Material(
                          child: new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 1.0),
                            child: new IconButton(
                              icon: new Icon(Icons.face),
                              onPressed: () {
                                setState(() {
                                  isShowSticker = !isShowSticker;
                                });
                              },
                              color: Colors.blueGrey,
                            ),
                          ),
                          color: Colors.white,
                        ),

                        // Edit text
                        Flexible(
                          child: Container(
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15.0),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Type your message...',
                                hintStyle: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ),

                        // Button send message
                        Material(
                          child: new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 8.0),
                            child: new IconButton(
                              icon: new Icon(Icons.send),
                              onPressed: () {},
                              color: Colors.blueGrey,
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        border: new Border(
                            top: new BorderSide(
                                color: Colors.blueGrey, width: 0.5)),
                        color: Colors.white),
                  ),

                  // Sticker
                  (isShowSticker ? buildSticker() : Container()),
                ],
              ),
            ],
          ),
          onWillPop: onBackPress),
    );
  }

  Widget buildSticker() {
    return SizedBox(
      height: 220,
      child: EmojiPicker(
        config: Config(
            columns: 7,
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: const Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecentsText: 'No Recents',
            noRecentsStyle:
                const TextStyle(fontSize: 20, color: Colors.black26),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL),
        onEmojiSelected: (emoji, category) {
          if (!mounted) setState(() {});
          print(emoji);
        },
      ),
    );
  }
}
