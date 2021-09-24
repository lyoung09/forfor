import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forfor/login/controller/bind/authcontroller.dart';

import 'package:get/get.dart';

class SignUp extends GetWidget<AuthController> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void signUpLoginButton() async {
    if (_formKey.currentState!.validate()) {
      controller.createUser(_emailControl.text, _passwordControl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
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
                "Create an account",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: width * 0.7,
              height: 60,
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
              height: 60,
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
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  child: TextButton(
                    child: Text(
                      "skip >",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: signUpLoginButton,
                  ),
                  padding: EdgeInsets.only(right: 15),
                )),
          ],
        ),
      ),
    );
  }
}
