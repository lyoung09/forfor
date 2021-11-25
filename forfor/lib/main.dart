import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:forfor/bottomScreen/chat/chat.dart';
import 'package:forfor/bottomScreen/chat/chatting_detail.dart';

import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/bottomScreen/group/groupPage/hidden_drawer.dart/hidden.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/infomation/sayScreen.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/controller/bind/authcontroller.dart';

import 'package:forfor/login/screen/login_main.dart';
import 'package:forfor/login/screen/hopeInfo.dart';

import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/model/category.dart';
import 'package:forfor/service/notification_service.dart';

import 'package:forfor/service/userdatabase.dart';
import 'package:location/location.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bottomScreen/group/groupPage/groupFriend.dart';
import 'bottomScreen/group/groupPage/groupHome.dart';
import 'bottomScreen/group/groupPage/groupPosting.dart';
import 'bottomScreen/group/groupPage/groupQnA.dart';
import 'bottomScreen/group/groupPage/groupSearch.dart';

import 'controller/bind/authbinding.dart';
import 'home/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login/screen/show.dart';
import 'model/user.dart';
import 'utils/permissionhadler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.data["room"] == "chatting") {
    NotificationShow.flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.data['title'],
        message.data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ));

    Get.to(() => ChattingDetail(
          messageFrom: message.data["otherId"],
          messageTo: message.data["myId"],
          chatId: message.data["chattingId"],
        ));
  }
  if (message.data["room"] == "group") {
    // flutterLocalNotificationsPlugin.show(
    //   message.notification.hashCode,
    //   message.data['title'],
    //   message.data['body'],
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       channel.id,
    //       channel.name,
    //       channel.description,
    //       color: Colors.blue,
    //       playSound: true,
    //       icon: '@mipmap/ic_launcher',
    //     ),
    //   ));

    // Get.to(() => ChattingDetail(
    //       messageFrom: message.data["otherId"],
    //       messageTo: message.data["myId"],
    //       chatId: message.data["chattingId"],
    //     ));
  }
  if (message.data["room"] == "buddy") {
    NotificationShow.flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.data['title'],
        message.data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoContext.clientId = "bbc30e62de88b34dadbc0e199b220cc4";
  KakaoContext.javascriptClientId = "3a2436ea281f9a46f309cef0f4d05b25";
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationShow().init();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          tabBarTheme: TabBarTheme(labelColor: Colors.black)),
      home: MyHomePage(),
      routes: {
        '/groupPage': (context) {
          return SimpleHiddenDrawer(
            menu: Menu(),
            screenSelectedBuilder: (position, controller) {
              Widget screenCurrent = GroupHome(controller: controller);
              switch (position) {
                case 0:
                  screenCurrent = GroupHome(controller: controller);
                  break;
                case 1:
                  screenCurrent = GroupQnA(controller: controller);
                  break;
                case 2:
                  screenCurrent = GroupPosting(controller: controller);
                  break;
                case 3:
                  screenCurrent = GroupChatting(controller: controller);
                  break;
                case 4:
                  screenCurrent = GroupFriend(controller: controller);
                  break;
                case 5:
                  screenCurrent = GroupSearch(controller: controller);
                  break;
              }

              return Scaffold(
                body: screenCurrent,
              );
            },
          );
        },
        '/bottomScreen': (context) => BottomNavigation(),
        '/login': (context) => Login(),
        '/userInfomation': (context) => UserInfomation(),
        '/hopeInformation': (context) => HopeInfomation(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token;
  initState() {
    super.initState();

    getToken();
    getLoc();
    NotificationShow().mainInit();

    NotificationShow().onMessageListen();

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;

    //   final routeFromName = message.data["route"];
    //   print('${routeFromName} asas');
    //   Get.to(() => ChattingDetail(
    //         messageFrom: '7Ldq42bdxmbqQIp1PG2Mxii6MnF3',
    //         messageTo: '9UbDWOQrLOXirtzGQEwMUiuVnGb2',
    //         chatId: "4AS8GIib2QUJ1cOo6pTH",
    //       ));
    //   if (notification != null && android != null) {}
    // });
    //hoit();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  // void hoit() {
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing 1234",
  //       "How you doin ?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               channel.id, channel.name, channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  final Location location = Location();

  var latitude, longtitude;
  getLoc() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        startTime();
        return;
      }
    }
    startTime();
    // _currentPosition = await location.getLocation();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   prefs.setDouble("lat", _currentPosition.latitude!.toDouble());
    //   prefs.setDouble("lng", _currentPosition.longitude!.toDouble());
    // });
    // AuthController().initLoc(
    //     _currentPosition.latitude ?? -1, _currentPosition.longitude ?? -1);
  }

  startTime() async {
    return new Timer(Duration(milliseconds: 50), () {
      checkFirstSeen();
    });
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

  bool userData = false;
  userDb(uid) async {
    DocumentSnapshot ds = await UserDatabase().getUserDs(uid);

    this.setState(() {
      userData = ds.exists;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final controller = Get.put(AuthController());
  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      try {
        await userDb(controller.user!.uid);

        if (!userData) {
          controller.deleteUser();

          Get.offAll(() => MainLogin());
        } else {
          if (token != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(controller.user!.uid)
                .update({"token": token});
          }
          Get.offAll(() => BottomNavigation());
        }
      } catch (e) {
        Get.offAll(() => MainLogin());
      }
    } else {
      prefs.setBool('seen', true);
      Get.offAll(() => MainLogin());
    }
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return ChatUserList();
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("userLocation.latitude.toString()"),
              )
            ],
          ),
        ));
  }
}
