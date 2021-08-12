import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.black,
        toolbarHeight: size.height * 0.06,
        automaticallyImplyLeading: false,
        title: Text(
          "프로필",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: TextButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            SharedPreferences prefs = await SharedPreferences.getInstance();

            setState(() {
              prefs.setBool('login', false);
            });
          },
          child: Text("logout")),
    );
  }
}
