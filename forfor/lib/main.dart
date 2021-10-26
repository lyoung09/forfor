import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forfor/bottomScreen/buddy/nearUser.dart';
import 'package:forfor/bottomScreen/chat/chat.dart';
import 'package:forfor/bottomScreen/group/group.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/bottomScreen/group/groupPage/hidden_drawer.dart/hidden.dart';
import 'package:forfor/login/controller/bind/authbinding.dart';

import 'package:forfor/login/screen/login_main.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/login/screen/show.dart';
import 'package:forfor/login/screen/userInfo.dart';

import 'package:forfor/service/userdatabase.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:location/location.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bottomScreen/buddy/invitePeopleScreen.dart';
import 'bottomScreen/group/addGroupStepper.dart';
import 'bottomScreen/group/groupPage/groupFriend.dart';
import 'bottomScreen/group/groupPage/groupHome.dart';
import 'bottomScreen/group/groupPage/groupPosting.dart';
import 'bottomScreen/group/groupPage/groupQnA.dart';
import 'bottomScreen/group/groupPage/groupSearch.dart';
import 'bottomScreen/group/group_click.dart';
import 'bottomScreen/group/groupclick.dart';
import 'bottomScreen/infomation/infomationDetail/WritingPage.dart';
import 'bottomScreen/infomation/sayScreen.dart';
import 'bottomScreen/otherProfile/a.dart';
import 'bottomScreen/profile/my_profile.dart';
import 'bottomScreen/profile/my_update.dart';
import 'home/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login/controller/bind/authcontroller.dart';
import 'login/controller/bind/usercontroller.dart';
import 'model/userLocation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoContext.clientId = "bbc30e62de88b34dadbc0e199b220cc4";
  KakaoContext.javascriptClientId = "3a2436ea281f9a46f309cef0f4d05b25";
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
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
        '/writingpage': (context) => WritingPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  initState() {
    super.initState();
    getLoc();

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print('token ${token}');
    });

    //permission();
  }

  final Location location = Location();
  late LocationData _currentPosition;

  PermissionStatus? _permissionGranted;
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
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   hohoh();
    // });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved 123");
      print(event.notification!.title);
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text("Notification"),
      //         content: Text(event.notification!.body!),
      //         actions: [
      //           TextButton(
      //             child: Text("Ok"),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           )
      //         ],
      //       );
      //     });
    });

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
    print(ds);
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
    // if (_seen) {
    //   try {
    //     await userDb(controller.user!.uid);

    //     if (!userData) {
    //       controller.deleteUser();

    //       Get.offAll(() => MainLogin());
    //     } else {
    //       Get.offAll(() => BottomNavigation());
    //     }
    //   } catch (e) {
    //     Get.offAll(() => MainLogin());
    //   }
    // } else {
    //   prefs.setBool('seen', true);
    // }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatUserList();
        },
      ),
    );
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

  hohoh() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved 123");

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   CollectionReference _productss =
//       FirebaseFirestore.instance.collection('user');

//   initState() {
//     super.initState();
//     var a;

// //Do
//   }

//   // This function is triggered when the floatting button or one of the edit buttons is pressed
//   // Adding a product if no documentSnapshot is passed
//   // If documentSnapshot != null then update an existing product
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';

//     // print('documentSnapshot! ${documentSnapshot!}');
//     if (documentSnapshot != null) {
//       action = 'update';
//       _nameController.text = documentSnapshot['name'];
//       _priceController.text = documentSnapshot['price'].toString();
//     }

//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   controller: _priceController,
//                   decoration: InputDecoration(
//                     labelText: 'Price',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: Text(action == 'create' ? 'Create' : 'Update'),
//                   onPressed: () async {
//                     final String? name = _nameController.text;
//                     final double? price =
//                         double.tryParse(_priceController.text);
//                     if (name != null && price != null) {
//                       if (action == 'create') {
//                         // Persist a new product to Firestore
//                         await _productss.add({"name": name, "price": price});
//                       }

//                       if (action == 'update') {
//                         // Update the product

//                         await _productss
//                             .doc(documentSnapshot?.id)
//                             .update({"name": name, "price": price});
//                       }

//                       // Clear the text fields
//                       _nameController.text = '';
//                       _priceController.text = '';

//                       // Hide the bottom sheet
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   // Deleteing a product by id
//   Future<void> _deleteProduct(String productId) async {
//     await _productss.doc(productId).delete();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('You have successfully deleted a product')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kindacode.com'),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _productss.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(documentSnapshot['price'].toString()),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           // Press this button to edit a single product
//                           IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () =>
//                                   _createOrUpdate(documentSnapshot)),
//                           // This icon button is used to delete a single product
//                           IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       // Add new product
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _createOrUpdate(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
