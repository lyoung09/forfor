import 'package:flutter/material.dart';

class InformationMainScreen extends StatefulWidget {
  const InformationMainScreen({Key? key}) : super(key: key);

  @override
  _InformationMainScreenState createState() => _InformationMainScreenState();
}

class _InformationMainScreenState extends State<InformationMainScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: size.height * 0.06,
        // backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "정보 교환",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
