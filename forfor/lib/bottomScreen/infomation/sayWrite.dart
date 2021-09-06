import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfor/widget/my_text.dart';

class SayWriting extends StatefulWidget {
  const SayWriting({Key? key}) : super(key: key);

  @override
  _SayWritingState createState() => _SayWritingState();
}

class _SayWritingState extends State<SayWriting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget bottomModal() {
    return SingleChildScrollView(
      child: Container(
        height: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.photo),
              title: new Text('Photo'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Music'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.share),
              title: new Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SingleChildScrollView(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.photo),
              title: new Text('Photo'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Music'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.share),
              title: new Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool modalCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.black,
          iconSize: 30,
          onPressed: () {
            Navigator.of(context).pop();
          },
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
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: CupertinoTextField(
                cursorColor: Colors.black,
                textAlign: TextAlign.left,
                maxLines: 30,
                keyboardType: TextInputType.multiline,
                autofocus: false,
              ),
            ),
            // Padding(padding: EdgeInsets.only(top: 20)),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   child: Card(
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         IconButton(
            //           icon: Icon(Icons.camera_alt),
            //           onPressed: () {},
            //           iconSize: 32,
            //         ),
            //         Padding(padding: EdgeInsets.only(right: 5)),
            //         Text("camera",
            //             style: TextStyle(color: Colors.black, fontSize: 20))
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.only(top: 10)),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   child: Card(
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         IconButton(
            //           iconSize: 32,
            //           icon: Icon(Icons.voicemail),
            //           onPressed: () {},
            //         ),
            //         Padding(padding: EdgeInsets.only(right: 5)),
            //         Text("voice",
            //             style: TextStyle(color: Colors.black, fontSize: 20))
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomSheet: bottomModal(),
    );
  }
}
