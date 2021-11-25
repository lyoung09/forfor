import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forfor/bottomScreen/chat/chatting_detail.dart';
import 'package:get/get.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

class NotificationShow {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  mainInit() {
    var initialzationsettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initialzationsettingIos = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    var initSetting = InitializationSettings(
        android: initialzationsettingAndroid, iOS: initialzationsettingIos);

    flutterLocalNotificationsPlugin.initialize(initSetting);
  }

  onMessageListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> data = message.data;
      String? screen = data['screen'].toString();

      if (message.data.isNotEmpty) {
        flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            data['title'],
            data['body'],
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  color: Colors.blue,
                  playSound: false,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: IOSNotificationDetails(
                    presentAlert: true, presentSound: true)),
            payload: screen);
        if (data["room"] == "chatting") {
          Get.to(() => ChattingDetail(
                messageFrom: data["otherId"],
                messageTo: data["myId"],
                chatId: data["chattingId"],
              ));
        }
        if (data["room"] == "group") {}
        if (data["room"] == "buddy") {}
      }
    });
  }

  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   if (message.data["room"] == "chatting") {
  //     flutterLocalNotificationsPlugin.show(
  //         message.notification.hashCode,
  //         message.data['title'],
  //         message.data['body'],
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channel.description,
  //             color: Colors.blue,
  //             playSound: true,
  //             icon: '@mipmap/ic_launcher',
  //           ),
  //         ));

  //     Get.to(() => ChattingDetail(
  //           messageFrom: message.data["otherId"],
  //           messageTo: message.data["myId"],
  //           chatId: message.data["chattingId"],
  //         ));
  //   }
  //   if (message.data["room"] == "group") {
  //     // flutterLocalNotificationsPlugin.show(
  //     //   message.notification.hashCode,
  //     //   message.data['title'],
  //     //   message.data['body'],
  //     //   NotificationDetails(
  //     //     android: AndroidNotificationDetails(
  //     //       channel.id,
  //     //       channel.name,
  //     //       channel.description,
  //     //       color: Colors.blue,
  //     //       playSound: true,
  //     //       icon: '@mipmap/ic_launcher',
  //     //     ),
  //     //   ));

  //     // Get.to(() => ChattingDetail(
  //     //       messageFrom: message.data["otherId"],
  //     //       messageTo: message.data["myId"],
  //     //       chatId: message.data["chattingId"],
  //     //     ));
  //   }
  //   if (message.data["room"] == "buddy") {
  //     flutterLocalNotificationsPlugin.show(
  //         message.notification.hashCode,
  //         message.data['title'],
  //         message.data['body'],
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channel.description,
  //             color: Colors.blue,
  //             playSound: true,
  //             icon: '@mipmap/ic_launcher',
  //           ),
  //         ));
  //   }
  // }
}
