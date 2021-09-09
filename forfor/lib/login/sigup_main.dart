import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/signupD/userInfo.dart';
import 'package:email_auth/email_auth.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  final TextEditingController _otpControl = new TextEditingController();
  bool checkOtp = false;
  bool verifyOtp = false;
  bool canSignUp = false;
  bool passwordRule = true;
  bool emailRule = true;

  void sendOtp() async {
    EmailAuth.sessionName = "forfor";

    var res = await EmailAuth.sendOtp(receiverMail: _emailControl.text);
    setState(() {
      if (res) {
        print("otp sent");
        checkOtp = true;
      } else {
        print("not sent");
      }
    });
  }

  void verifyOTP() async {
    var res = EmailAuth.validate(
        receiverMail: _emailControl.text, userOTP: _otpControl.text);
    setState(() {
      if (res) {
        print("OTP VERIFIED");
        verifyOtp = true;
      } else {
        print("invalid otp");
      }
    });
  }

  void dialog() {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              content: Text("wrong OTP number."),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('check'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }

  void checkDialog() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      canSignUp = true;
    });
    showDialog(context: context, builder: (_) => CustomCongratDialog());
  }

  void signUpLoginButton() async {
    if (_passwordControl.text.isEmpty || _passwordControl.text.length < 6) {
      if (canSignUp == true) {
        print("password wrong");
        setState(() {
          passwordRule = false;
        });
      } else {
        print("both email and password wrong");
        setState(() {
          passwordRule = false;
          emailRule = false;
        });
      }
    } else {
      if (canSignUp == true) {
        print("success");
        final email = _emailControl.text.trim();
        final password = _passwordControl.text.trim();

        User? user = FirebaseAuth.instance.currentUser;

        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser?.uid)
            .set({
          'uid': _auth.currentUser?.uid,
          'email': email,
          'password': password,
          'access': 'email'
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          prefs.setString("uid", user!.uid);
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UserInfomation();
            },
          ),
        );
      } else {
        print("email wrong");
        setState(() {
          emailRule = false;
        });
      }
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
      body: ListView(
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
          SizedBox(height: 30.0),
          // Container(
          //   padding: EdgeInsets.only(left: 15, right: 35),
          //   child: Card(
          //     elevation: 1.0,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(5.0),
          //         ),
          //       ),
          //       child: TextField(
          //         style: TextStyle(
          //           fontSize: 15.0,
          //           color: Colors.black,
          //         ),
          //         decoration: InputDecoration(
          //           contentPadding: EdgeInsets.all(10.0),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(5.0),
          //             borderSide: BorderSide(
          //               color: Colors.white,
          //             ),
          //           ),
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //               color: Colors.white,
          //             ),
          //             borderRadius: BorderRadius.circular(5.0),
          //           ),
          //           hintText: "Username",
          //           // prefixIcon: Icon(
          //           //   Icons.perm_identity,
          //           //   color: Colors.black,
          //           // ),
          //           hintStyle: TextStyle(
          //             fontSize: 15.0,
          //             color: Colors.black,
          //           ),
          //         ),
          //         maxLines: 1,
          //         controller: _usernameControl,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                width: width * 0.75,
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
                    ),
                  ),
                ),
              ),
              Container(
                width: width * 0.22,
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Colors.blue[200],
                          elevation: 2),
                      onPressed: () => sendOtp(),
                      child:
                          Text("OTP", style: TextStyle(color: Colors.black))),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          checkOtp == true && canSignUp == false
              ? Row(
                  children: [
                    Container(
                      width: width * 0.8,
                      padding: EdgeInsets.only(left: 15, right: 5),
                      child: Card(
                        elevation: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            ),
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
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),

                              // prefixIcon: Icon(
                              //   Icons.mail_outline,
                              //   color: Colors.black,
                              // ),
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            maxLines: 1,
                            controller: _otpControl,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: Colors.blue,
                            elevation: 1),
                        onPressed: () {
                          verifyOTP();
                          verifyOtp == true ? checkDialog() : dialog();
                        },
                        child: Text("Check",
                            style: TextStyle(color: Colors.black)))
                  ],
                )
              : SizedBox(height: 20.0),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.only(left: 15, right: 35),
            width: width * 0.7,
            child: Card(
              elevation: 0.0,
              child: Container(
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Password(At least 6 character)",
                    // prefixIcon: Icon(
                    //   Icons.lock_outline,
                    //   color: Colors.black,
                    // ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  controller: _passwordControl,
                  obscureText: true,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          passwordRule == true
              ? Text("")
              : Container(
                  padding: EdgeInsets.only(left: 20, right: 35),
                  width: width * 0.8,
                  child: Text(
                    "check your password! (at least 6)",
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  )),

          // SizedBox(height: 20.0),
          // Container(
          //   padding: EdgeInsets.only(left: 15, right: 35),
          //   child: Card(
          //     elevation: 1.0,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(5.0),
          //         ),
          //       ),
          //       child: TextField(
          //         style: TextStyle(
          //           fontSize: 15.0,
          //           color: Colors.black,
          //         ),
          //         decoration: InputDecoration(
          //           contentPadding: EdgeInsets.all(10.0),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(5.0),
          //             borderSide: BorderSide(
          //               color: Colors.white,
          //             ),
          //           ),
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //               color: Colors.white,
          //             ),
          //             borderRadius: BorderRadius.circular(5.0),
          //           ),
          //           hintText: "Password",
          //           // prefixIcon: Icon(
          //           //   Icons.lock_outline,
          //           //   color: Colors.black,
          //           // ),
          //           hintStyle: TextStyle(
          //             fontSize: 15.0,
          //             color: Colors.black,
          //           ),
          //         ),
          //         obscureText: true,
          //         maxLines: 1,
          //         controller: _passwordCheckControl,
          //       ),
          //     ),
          //   ),
          // ),
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
    );
  }
}
