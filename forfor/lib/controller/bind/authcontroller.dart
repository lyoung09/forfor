import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forfor/controller/bind/usercontroller.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/user.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:forfor/widget/loading.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart' as kakaotalUser;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late String email;
  late String access;
  late String gender;
  late String country;
  late String nickname;
  late String url;
  late String timeStamp;
  late String introduction;
  late double lat;
  late double lng;
  late String address;
  late List<dynamic> list;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rxn<User> _user = Rxn<User>();
  late DocumentSnapshot ds;
  User? get user => _user.value;
  String? errorType;
  @override

  // ignore: must_call_super
  void onInit() async {
    _user.bindStream(_auth.authStateChanges());
  }

  initLoc(double latitude, double longitude) async {
    this.lat = latitude;
    this.lng = longitude;

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // this.lat = prefs.getDouble("lat") ?? -1;
    // this.lng = prefs.getDouble("lng") ?? -1;

    if (this.lat == -1) {
      this.address = "";
    } else {
      print(this.lat);
      final coordinates = new Coordinates(this.lat, this.lng);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;

      this.address = '${first.locality} ${first.countryName}';
      print(this.address);
    }
  }

  saveLocation(String uid, double latitude, double longitude) async {
    this.lat = latitude;
    this.lng = longitude;

    if (this.lat == -1) {
      this.address = "";
      updateUserLocatioin(uid, -1.2, -1.2, "");
    } else {
      final coordinates = new Coordinates(this.lat, this.lng);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;

      this.address = '${first.adminArea.capitalize}';
      // print(
      //     '${first.adminArea.capitalize}, ${first.coordinates} ${first.countryCode} ${first.countryName} ${first.featureName} ${first.subAdminArea} ${first.subLocality} ${first.subThoroughfare} ${first.thoroughfare}');
      updateUserLocatioin(uid, this.lat, this.lng, this.address);
    }
    return this.address;
    // this.address=first.
  }

  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // on iOS
    } else {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId; // on Android
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _auth.setLanguageCode("ko");
      print(email);
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case 'user-not-found':
          errorType = "no existing accout";
          break;
        case 'invalid-email':
          errorType = "invalid email";
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = "newtwork error";
          break;

        // ...
        default:
          errorType = error.code;
      }

      Get.defaultDialog(
        title: "Error",
        middleText: errorType!,
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        onConfirm: () {
          Get.back();
        },
        onCancel: () {
          Get.back();
        },
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );
    }
  }

  void createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      this.uid = _auth.currentUser!.uid;
      this.email = email.trim();
      this.access = "email";
      Get.offAll(() => UserInfomation());
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case 'email-already-in-use':
          errorType = "email already exists";
          break;

        // ...
        default:
          errorType = error.code;
      }

      Get.defaultDialog(
        title: "Error",
        middleText: errorType!,
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        onCancel: () {
          Get.back();
        },
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );
    }
  }

  addUserInformation(String gender, String country, String nickname, String url,
      String introduction) {
    this.gender = gender.trim();
    this.country = country.trim();
    this.nickname = nickname.trim();
    this.url = url.trim();
    this.introduction = introduction.trim();

    Get.to(() => HopeInfomation());
  }

  void setUserDatabase(List<dynamic> list) async {
    try {
      String deviceId = await getDeviceId();
      DateTime currentPhoneDate = DateTime.now(); //DateTime

      Timestamp myTimeStamp =
          Timestamp.fromDate(currentPhoneDate); //To TimeStamp

      DateTime myDateTime = myTimeStamp.toDate();
      this.list = list;
      this.timeStamp = myDateTime.toString();

      UserModel _user = UserModel(
          id: this.uid,
          email: this.email,
          access: this.access,
          gender: this.gender,
          country: this.country,
          nickname: this.nickname,
          url: this.url,
          deviceId: deviceId,
          introduction: this.introduction,
          // address: this.address,
          // lat: this.lat,
          // lng: this.lng,
          timeStamp: myDateTime.toString(),
          category: list);

      if (await UserDatabase().addDataUser(_user)) {
        Get.put(UserController()).user = _user;
      }
      Get.offAll(() => BottomNavigation());
    } catch (e) {}
  }

  void updateUserDatabase(UserModel user, String? nickname, String url,
      String? introduction, List<dynamic>? list) async {
    try {
      print(introduction);
      UserModel _user = UserModel(
          id: user.id,
          email: user.email,
          access: user.access,
          gender: user.gender,
          country: user.country,
          nickname: nickname,
          url: url,
          category: list,
          timeStamp: user.timeStamp,
          introduction: introduction);

      if (await UserDatabase().updateDataUser(_user)) {
        Get.put(UserController()).user = _user;
      }

      Get.offAll(() => BottomNavigation(index: 4));
    } catch (e) {}
  }

  void updateUserLocatioin(
      String uid, double lat, double lng, String addr) async {
    try {
      if (await UserDatabase()
          .updateLocationUser(_auth.currentUser!.uid, lat, lng, addr)) {
        Get.put(UserController()).user.lat = lat;
        Get.put(UserController()).user.lng = lng;
        Get.put(UserController()).user.address = addr;
      }
    } catch (e) {}
  }

  issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);

      AccessTokenStore.instance.toStore(token);
      final kakaotalUser.User userKakao =
          await kakaotalUser.UserApi.instance.me();

      List<String> providers = await _auth
          .fetchSignInMethodsForEmail(userKakao.kakaoAccount?.email ?? "");

      if (providers.length > 0) {
        await _auth.signInWithEmailAndPassword(
            email: userKakao.kakaoAccount?.email ?? "",
            password: "kakaologinuser");

        Get.to(() => BottomNavigation());
      } else {
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
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorType = "newtwork error";
          break;

        default:
          errorType = e.code;
      }
      Get.defaultDialog(
        title: "Error",
        middleText: errorType!,
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );
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

      DocumentSnapshot ds =
          await UserDatabase().getUserDs(_auth.currentUser!.uid);

      if (ds.get("deviceId") != await getDeviceId()) {
        // Get.defaultDialog(
        //   title: "Error",
        //   middleText: "user in use ",
        //   backgroundColor: Colors.white,
        //   middleTextStyle: TextStyle(color: Colors.black),
        //   textCancel: "ok",
        //   buttonColor: Colors.white,
        //   cancelTextColor: Colors.black,
        // );
//        )

        UserDatabase()
            .currentUserChange(_auth.currentUser!.uid, await getDeviceId());
      }

      Get.put(UserController()).user =
          await UserDatabase().getUser(_auth.currentUser!.uid);

      Get.offAll(BottomNavigation());
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case 'user-not-found':
          errorType = "no user";
          break;
        case 'wrong-password':
          errorType = "wrong password";
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = "newtwork error";
          break;
        case 'invalid-email':
          errorType = "email style wrong";
          break;
        // ...
        default:
          errorType = error.code;
      }

      Get.defaultDialog(
        title: "Error",
        middleText: errorType!,
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(color: Colors.black),
        textCancel: "ok",
        onConfirm: () {
          Get.back();
        },
        onCancel: () {
          Get.back();
        },
        buttonColor: Colors.white,
        cancelTextColor: Colors.black,
      );

      // Get.defaultDialog(
      //   backgroundColor: Colors.white,
      //   title: errorType!,
      //   textConfirm: "Confirm",
      //   confirmTextColor: Colors.black,
      //   buttonColor: Colors.white,
      //   barrierDismissible: false,
      // );
    }
  }

  logoutUser() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      await kakaotalUser.UserApi.instance.logout();
      Get.find<UserController>().clear();
    } catch (e) {
      print("hoithoit ${e}");
    }
  }

  logoutTalk() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
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

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
