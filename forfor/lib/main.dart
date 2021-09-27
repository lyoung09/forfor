import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forfor/bottomScreen/group/group.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/bottomScreen/group/groupPage/hidden_drawer.dart/hidden.dart';
import 'package:forfor/bottomScreen/otherProfile/userProfile.dart';
import 'package:forfor/login/controller/bind/authbinding.dart';

import 'package:forfor/login/screen/login_main.dart';
import 'package:forfor/login/screen/hopeInfo.dart';
import 'package:forfor/login/screen/userInfo.dart';
import 'package:forfor/login/screen/sigup_main.dart';
import 'package:forfor/service/userdatabase.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:kakao_flutter_sdk/all.dart';

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
import 'bottomScreen/profile/my_update.dart';
import 'home/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login/controller/bind/authcontroller.dart';
import 'login/controller/bind/usercontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoContext.clientId = "bbc30e62de88b34dadbc0e199b220cc4";
  KakaoContext.javascriptClientId = "3a2436ea281f9a46f309cef0f4d05b25";
  await Firebase.initializeApp();
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
          visualDensity: VisualDensity.adaptivePlatformDensity),
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
    startTime();
  }

  startTime() async {
    return new Timer(Duration(milliseconds: 500), () {
      checkFirstSeen();
    });
  }

  bool userData = false;

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool _seen = (prefs.getBool('seen') ?? false);
    final controller = Get.put(AuthController());

    if (controller.user?.uid != null) {
      print(controller.user?.uid);
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("users")
          .doc(controller.user!.uid)
          .get();

      this.setState(() {
        userData = ds.exists;
      });

      if (!userData) {
        controller.deleteUser();
        Navigator.pushNamed(context, '/login');
      } else {
        Navigator.pushNamed(context, '/bottomScreen');
      }
    } else {
      Navigator.pushNamed(context, '/login');
    }
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return UserUpdate();
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
              child: Text("hello world"),
            )
          ],
        ),
      ),
    );
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
