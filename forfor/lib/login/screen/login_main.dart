import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/widget/button/signupButton/googlebutton.dart';
import 'package:forfor/login/widget/button/signupButton/kakaobutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/screen/sigup_main.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  Future<bool> _willPopCallback() async {
    return false;
  }

  buttonLogin() async {
    final email = _usernameControl.text;
    final password = _passwordControl.text;
    controller.loginUser(email, password);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[400],
          automaticallyImplyLeading: false,
          title: Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
          ),
          actions: [],
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Card(
                elevation: 0.0,
                child: Container(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _usernameControl,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Card(
                elevation: 0.0,
                child: Container(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Password",

                      // prefixIcon: Icon(
                      //   Icons.lock_outline,
                      //   color: Colors.black,
                      // ),
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    obscureText: true,
                    maxLines: 1,
                    controller: _passwordControl,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 35),
              child: TextButton(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 50.0,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(color: Colors.black, width: 1)),
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: buttonLogin),
            ),
            SizedBox(height: 15.0),
            Container(
              child: Divider(
                thickness: 2.5,
                color: Colors.grey[400],
              ),
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(left: 45, right: 45),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SignUp();
                      },
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            15.0) //                 <--- border radius here
                        ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/email.png",
                          height: 25.0,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
                        Text(
                          'Email signup',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'nanumB'),
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(height: 35.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.2,
                    ),
                    GoogleButton(),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    KaKaoButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
