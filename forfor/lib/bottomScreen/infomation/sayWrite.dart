import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:forfor/widget/my_text.dart';

class SayWriting extends StatefulWidget {
  const SayWriting({Key? key}) : super(key: key);

  @override
  _SayWritingState createState() => _SayWritingState();
}

class _SayWritingState extends State<SayWriting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(Icons.cancel),
          color: Colors.black,
          iconSize: 30,
          onPressed: () {},
        ),
        title: Text("say", style: TextStyle(color: Colors.black, fontSize: 35)),
        centerTitle: true,
        actions: [
          IconButton(
            color: Colors.black,
            iconSize: 30,
            icon: Icon(Icons.send),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50)),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 30),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Bubble(
                showNip: true,
                padding: BubbleEdges.all(60),
                alignment: Alignment.centerRight,
                nip: BubbleNip.rightCenter,
                nipHeight: 50,
                nipWidth: 50,
                margin: const BubbleEdges.all(4),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.amber[500],
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle:
                        MyText.body1(context)!.copyWith(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
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
          ],
        ),
      ),
    );
  }
}
