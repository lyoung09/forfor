import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  final controller = Get.put(AuthController());

  signInwithGoogle() async {
    controller.googleCreteUser();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: signInwithGoogle,
      fillColor: Colors.white,
      shape: CircleBorder(),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(17.5),
        child: Icon(
          FontAwesomeIcons.google,
          // color: Colors.transparent,
          size: 35,
        ),
      ),
    );
  }
}
