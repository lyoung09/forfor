import 'package:flutter/material.dart';

//login screen  <kakao wechat google instagram line>

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(),
            Padding(padding: EdgeInsets.only(bottom: height*0.02)),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
