import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart' as kakaotalUser;

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override

  // ignore: must_call_super
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      UserModel _user = UserModel(
        id: _auth.currentUser!.uid,
        email: email.trim(),
      );

      if (await UserDatabase().createNewUser(_user)) {
        Get.put(UserController()).user = _user;
      }
      Get.offAll(() => UserInfomation());
    } catch (e) {}
  }

  void addUserDB(
      String gender, String country, String nickname, String url) async {
    try {
      UserModel _user = UserModel(
        gender: gender,
        country: country,
        nickname: nickname,
        url: url,
      );

      if (await UserDatabase().addDataUser(_user)) {
        Get.put(UserController()).user = _user;
      }
      Get.offAll(() => HopeInfomation());
    } catch (e) {
      await _auth.currentUser?.delete();
      Get.find<UserController>().clear();
    }
  }

  issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);

      AccessTokenStore.instance.toStore(token);
      final kakaotalUser.User userKakao =
          await kakaotalUser.UserApi.instance.me();
      List<String> providers = await _auth
          .fetchSignInMethodsForEmail(userKakao.kakaoAccount?.email ?? "");

      if (providers.isEmpty && providers.length > 0) {
        print("already has providers: ${providers.toString()}");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userKakao.kakaoAccount?.email ?? "",
            password: "kakaologinuser");

        Get.to(() => BottomNavigation());
      } else {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userKakao.kakaoAccount?.email ?? "",
                password: "kakaologinuser");
        if (userCredential.additionalUserInfo!.isNewUser) {
          UserModel _user = UserModel(
            id: user?.uid,
            email: user?.email,
          );

          if (await UserDatabase().createNewUser(_user)) {
            Get.put(UserController()).user = _user;

            Get.offAll(UserInfomation());
          }
        } else {
          Get.offAll(BottomNavigation());
        }
      }
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  void googleCreteUser() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;

    if (userCredential.additionalUserInfo!.isNewUser) {
      UserModel _user = UserModel(
        id: user?.uid,
        email: user?.email,
      );

      if (await UserDatabase().createNewUser(_user)) {
        Get.put(UserController()).user = _user;

        Get.offAll(UserInfomation());
      }
    } else {
      Get.offAll(BottomNavigation());
    }
  }

  void google_signOut() async {
    await googleSignIn.signOut();
  }

  void loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.put(UserController()).user =
          await UserDatabase().getUser(_auth.currentUser!.uid);

      Get.offAll(UserInfomation());
    } catch (e) {}
  }

  void logoutUser() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {}
  }
}
