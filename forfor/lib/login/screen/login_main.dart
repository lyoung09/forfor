import 'package:forfor/controller/bind/authcontroller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forfor/login/screen/sigup_main.dart';

import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange[50],
          title: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 28),
          ),
          actions: [],
        ),
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
          SizedBox(height: 15.0),
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
          SizedBox(height: 20.0),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 35),
            child: TextButton(
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Write your email'),
                        content: TextFormField(
                          controller: _emailControl,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  controller
                                      .resetPassword(_emailControl.text.trim());
                                },
                              ),
                              FlatButton(
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Text('cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    });
                //controller.resetPassword("");
              },
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: 50.0,
            padding: EdgeInsets.only(left: 40, right: 40),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.orange[200],
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
                child: Center(
                  child: Text(
                    '계정이 없으신가요? 가입하기',

                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'nanumB'),

                    // child: Row(

                    //     mainAxisAlignment: MainAxisAlignment.center,

                    //     children: [

                    //       Image.asset(

                    //         "assets/icon/email.png",

                    //         height: 25.0,

                    //       ),

                    //       Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),

                    //       Text(

                    //         'Email signup',

                    //         style: TextStyle(

                    //             color: Colors.black,

                    //             fontSize: 15.0,

                    //             fontWeight: FontWeight.w500,

                    //             fontFamily: 'nanumB'),

                    //       )

                    //     ]),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 35.0),
            // Center(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: Row(
            //       children: <Widget>[
            //         SizedBox(
            //           width: width * 0.2,
            //         ),
            //         GoogleButton(),
            //         SizedBox(
            //           width: width * 0.1,
            //         ),
            //         KaKaoButton(),
            //       ],
            //     ),
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}
