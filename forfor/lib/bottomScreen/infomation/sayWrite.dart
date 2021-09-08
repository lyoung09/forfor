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

  Widget bottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 30)),
            Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                  )),
            ),

            //IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(color: Colors.black, height: 1.4, fontSize: 16);
    TextStyle labelStyle = TextStyle(color: Colors.white);
    UnderlineInputBorder lineStyle1 = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1));
    UnderlineInputBorder lineStyle2 = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amber[500]!, width: 2));

    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[400],
          title: Text("Question",
              style: TextStyle(color: Colors.grey[900], fontSize: 25)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 25,
              color: Colors.grey[900],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 25,
                color: Colors.grey[900],
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.send_outlined,
                size: 25,
                color: Colors.grey[900],
              ),
              onPressed: () {},
            ),
          ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 20),
                TextField(
                  style: textStyle,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black26,
                  maxLines: 15,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText:
                        'You can ask anything.\n But do not sexual and political and religious asking!',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 1),
                    ),
                  ),
                ),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
