import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/auth.dart';

import 'package:kakao_flutter_sdk/user.dart' as kakaotalUser;

class KaKaoButton extends StatefulWidget {
  const KaKaoButton({Key? key}) : super(key: key);

  @override
  _KaKaoButtonState createState() => _KaKaoButtonState();
}

class _KaKaoButtonState extends State<KaKaoButton> {
  final controller = Get.put(AuthController());
  bool _isKakaoTalkInstalled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initKakaoTalkInstalled();
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

      controller.issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

//카카오 로그인
  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();

      controller.issueAccessToken(code);
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
      List<String> providers = await firebaseAuth
          .fetchSignInMethodsForEmail(userKakao.kakaoAccount?.email ?? "");

      if (providers != null && providers.length > 0) {
        print("already has providers: ${providers.toString()}");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userKakao.kakaoAccount?.email ?? "",
            password: "kakaologinuser");

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return BottomNavigation();
        //     },
        //   ),
        // );
      } else {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userKakao.kakaoAccount?.email ?? "",
                password: "kakaologinuser");

        await FirebaseFirestore.instance
            .collection("users")
            .doc(
              userCredential.user?.uid,
            )
            .set({
          'uid': userCredential.user?.uid,
          'email': userKakao.kakaoAccount?.email,
          'access': 'kakao'
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UserInfomation();
            },
          ),
        );
      }
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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
    );
  }
}
