import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuddyMainScreen extends StatefulWidget {
  const BuddyMainScreen({Key? key}) : super(key: key);

  @override
  _BuddyMainScreenState createState() => _BuddyMainScreenState();
}

class _BuddyMainScreenState extends State<BuddyMainScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  initState() {
    super.initState();
    if (auth.currentUser != null) {
      print(auth.currentUser?.uid);
    }
  }

  Widget _category() {
    return Row(
      children: [],
    );
  }

  Widget _rightBanner() {
    return Container(
      child: Text("hoit"),
    );
  }

  Widget _vipIntroduction() {
    return Container(
      child: Text("ganbare"),
    );
  }

  Widget _todayBuddy() {
    return Card(child: Text("heelo"));
  }

  Widget _newBuddy() {
    return Card(child: Text("what a wonderful world"));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.06,
        centerTitle: true,
        // backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "버디 찾기",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            _vipIntroduction(),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            _category(),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            _rightBanner(),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            _todayBuddy(),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            _newBuddy()
          ],
        ),
      ),
    );
  }
}
