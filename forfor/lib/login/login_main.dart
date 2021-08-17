import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/signup/signupDetail/userInfo.dart';
import 'package:forfor/login/signup/sigup_main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:forfor/service/authService.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:kakao_flutter_sdk/auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kakao_flutter_sdk/user.dart' as kakaotalUser;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//login screen  <kakao wechat google instagram line>

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  bool _isKakaoTalkInstalled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KakaoContext.clientId = "bbc30e62de88b34dadbc0e199b220cc4";
    KakaoContext.javascriptClientId = "3a2436ea281f9a46f309cef0f4d05b25";
    _initKakaoTalkInstalled();
  }

  Future<bool> _willPopCallback() async {
    // await Show dialog of exit or what you want
    // then
    return false; //
  }

  //카카오 설치되있는지
  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  //카카오 설치요청
  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();

      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

//카카오 로그인
  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();

      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      AccessTokenStore.instance.toStore(token);
      final kakaotalUser.User userKakao =
          await kakaotalUser.UserApi.instance.me();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(token.accessToken)
          .set({
        'uid': token.accessToken,
        'email': userKakao.kakaoAccount?.email,
      });

      print(token.accessToken);
      // HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      //     'verifyToken',
      //     options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

      // final HttpsCallableResult result = await callable.call(
      //   <String, dynamic>{'token': token.accessToken},
      // );

      context.read<AuthService>().kakaologin(token.accessToken);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString("uid", token.accessToken);
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return UserInfomation();
          },
        ),
      );
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInwithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          'uid': user?.uid,
          'email': user?.email,
        });

        Navigator.pushNamed(context, '/userInfomation');
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .set({
            'uid': user?.uid,
            'email': user?.email,
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            prefs.setString("uid", user!.uid);
          });
          Navigator.pushNamed(context, '/userInfomation');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }

  buttonLogin() async {
    final email = _usernameControl.text.trim();
    final password = _passwordControl.text.trim();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();

    context
        .read<AuthService>()
        .login(snap.docs[0]['email'], snap.docs[0]['password']);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BottomNavigation();
        },
      ),
    );
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
          backgroundColor: Colors.blue[200],
          automaticallyImplyLeading: false,
          title: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.purple[900]),
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
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Card(
                elevation: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Password",
                      // prefixIcon: Icon(
                      //   Icons.lock_outline,
                      //   color: Colors.black,
                      // ),
                      hintStyle: TextStyle(
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
                    color: Colors.purple[900],
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
                    primary: Colors.blue[200],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.purple[900],
                    ),
                  ),
                  onPressed: buttonLogin),
            ),
            // SizedBox(height: 20.0),
            // Container(
            //   height: 50.0,
            //   padding: EdgeInsets.only(left: 30, right: 30),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.blue[200],
            //       onPrimary: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(32.0),
            //       ),
            //     ),
            //     child: Text(
            //       "SIGN UP".toUpperCase(),
            //       style: TextStyle(
            //         color: Colors.purple[900],
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (BuildContext context) {
            //             return SignUp();
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(height: 15.0),
            Container(
              child: Divider(
                thickness: 2.5,
                color: Colors.blue[800],
              ),
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
            ),

            // SizedBox(height: 20.0),
            // Container(
            //   padding: EdgeInsets.only(left: 45, right: 45),
            //   child: InkWell(
            //     // onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
            //     onTap: () {},
            //     child: Container(
            //       width: MediaQuery.of(context).size.width * 0.6,
            //       height: MediaQuery.of(context).size.height * 0.07,
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Colors.black,
            //           width: 1.5,
            //         ),
            //         borderRadius: BorderRadius.all(Radius.circular(
            //                 15.0) //                 <--- border radius here
            //             ),
            //       ),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               "assets/icon/instagramlogo.jpeg",
            //               height: 25.0,
            //             ),
            //             Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            //             Text(
            //               'instagram login',
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 15.0,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: 'nanumB'),
            //             )
            //           ]),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(left: 45, right: 45),
              child: InkWell(
                // onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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
            SizedBox(height: 25.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.2,
                    ),
                    RawMaterialButton(
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
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    RawMaterialButton(
                      onPressed: _isKakaoTalkInstalled
                          ? _loginWithTalk
                          : _loginWithKakao,
                      fillColor: Colors.yellow,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(17.5),
                        child: Image.asset(
                          "assets/icon/icon_kakao.png",
                          height: 35.0,
                          width: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 45, right: 45),
            //   child: InkWell(
            //     // onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
            //     onTap: signInwithGoogle,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width * 0.6,
            //       height: MediaQuery.of(context).size.height * 0.07,
            //       padding: EdgeInsets.only(left: 30, right: 30),
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Colors.black,
            //           width: 1.5,
            //         ),
            //         borderRadius: BorderRadius.all(Radius.circular(
            //                 15.0) //                 <--- border radius here
            //             ),
            //       ),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               "assets/icon/googlelogo.jpg",
            //               height: 25.0,
            //             ),
            //             Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            //             Text(
            //               'google login',
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 15.0,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: 'nanumB'),
            //             )
            //           ]),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 15.0),
            // Container(
            //   padding: EdgeInsets.only(left: 45, right: 45),
            //   child: InkWell(
            //     onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width * 0.6,
            //       height: MediaQuery.of(context).size.height * 0.07,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Colors.yellow),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               "assets/icon/icon_kakao.png",
            //               height: 25.0,
            //             ),
            //             Padding(padding: EdgeInsets.symmetric(horizontal: 7.0)),
            //             Text(
            //               'kakao login',
            //               style: TextStyle(
            //                   color: Colors.brown,
            //                   fontSize: 15.0,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: 'nanumB'),
            //             )
            //           ]),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
