import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/widget/loading.dart';

import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  bool start = false;
  void signUpLoginButton() async {
    if (_formKey.currentState!.validate()) {
      Get.dialog(Loading());
      controller.createUser(_emailControl.text, _passwordControl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          //automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.orange[50],
          title: Text(
            "Account",
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: width * 0.7,
              height: 80,
              padding: EdgeInsets.only(left: 10),
              child: Card(
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 13.0,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      // prefixIcon: Icon(
                      //   Icons.mail_outline,
                      //   color: Colors.black,
                      // ),
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _emailControl,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value)) {
                        return 'wrong email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Container(
              width: width * 0.7,
              height: 80,
              padding: EdgeInsets.only(left: 10),
              child: Card(
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 13.0,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      labelText: "Password(At least 6 character)",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    validator: (value) {
                      print(value?.length);
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'wrong password rule';
                      }

                      return null;
                    },
                    controller: _passwordControl,
                    obscureText: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
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
                    "START",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: signUpLoginButton),
            ),
          ],
        ),
      ),
    );
  }
}
