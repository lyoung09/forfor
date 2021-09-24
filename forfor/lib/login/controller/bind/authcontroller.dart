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
  late String uid;
  late String email;
  late String access;
  late String gender;
  late String country;
  late String nickname;
  late String url;
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

      this.uid = _auth.currentUser!.uid;
      this.email = email.trim();
      this.access = "email";
      Get.offAll(() => UserInfomation());
    } catch (e) {}
  }

  addUserInformation(
      String gender, String country, String nickname, String url) {
    this.gender = gender.trim();
    this.country = country.trim();
    this.nickname = nickname.trim();
    this.url = url.trim();

    Get.to(() => HopeInfomation());
  }

  void setUserDatabase(List<dynamic> list) async {
    try {
      UserModel _user = UserModel(
          id: this.uid,
          email: this.email,
          access: this.access,
          gender: this.gender,
          country: this.country,
          nickname: this.nickname,
          url: this.url,
          category: list);

      if (await UserDatabase().addDataUser(_user)) {
        Get.put(UserController()).user = _user;
      }
      Get.offAll(() => BottomNavigation());
    } catch (e) {}
  }

  issueAccessToken(String authCode) async {
    try {
      print("11");
      var token = await AuthApi.instance.issueAccessToken(authCode);

      AccessTokenStore.instance.toStore(token);
      final kakaotalUser.User userKakao =
          await kakaotalUser.UserApi.instance.me();

      List<String> providers = await _auth
          .fetchSignInMethodsForEmail(userKakao.kakaoAccount?.email ?? "");
      print(" prov${providers}");
      if (providers.length > 0) {
        await _auth.signInWithEmailAndPassword(
            email: userKakao.kakaoAccount?.email ?? "",
            password: "kakaologinuser");

        Get.to(() => BottomNavigation());
      } else {
        print("44");
        await _auth.createUserWithEmailAndPassword(
            email: userKakao.kakaoAccount?.email ?? "",
            password: "kakaologinuser");

        this.uid = user!.uid;
        this.email = userKakao.kakaoAccount!.email!;
        this.access = "kakao";
        Get.offAll(UserInfomation());
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
      this.uid = user!.uid;
      this.email = user.email!;
      this.access = "google";
      Get.offAll(UserInfomation());
    } else {
      Get.offAll(BottomNavigation());
    }
  }

  void google_signOut() async {
    try {
      await googleSignIn.signOut();
      Get.find<UserController>().clear();
    } catch (e) {}
  }

  void loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.put(UserController()).user =
          await UserDatabase().getUser(_auth.currentUser!.uid);

      Get.offAll(BottomNavigation());
    } catch (e) {}
  }

  logoutUser() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {}
  }

  logoutTalk() async {
    try {
      await _auth.signOut();
      await kakaotalUser.UserApi.instance.logout();
      Get.find<UserController>().clear();
    } catch (e) {}
  }

  deleteUser() {
    try {
      _auth.currentUser!.delete();
      Get.find<UserController>().clear();
    } catch (e) {}
  }
}