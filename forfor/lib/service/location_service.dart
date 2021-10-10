// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:forfor/login/controller/bind/usercontroller.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:get/get.dart';
// import 'package:forfor/login/controller/bind/authcontroller.dart';
// import 'package:forfor/model/userLocation.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocationService {
//   late UserLocation _currentLocation;

//   Stream<UserLocation> get locationStream => _locationController.stream;

//   Location location = Location();

//   StreamController<UserLocation> _locationController =
//       StreamController<UserLocation>.broadcast();

//   LocationService() {
//     location.requestPermission().then((granted) {
//       if (granted == PermissionStatus.granted) {
//         location.onLocationChanged.listen((event) {
//           _locationController.add(UserLocation(
//               latitude: event.latitude!.toDouble(),
//               longtitude: event.longitude!.toDouble()));
//         });
//       } else {
//         print("not allow userLocation");
//       }
//     });
//   }

//   late LocationData _currentPosition;

//   getLoc() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentPosition = await location.getLocation();

//     // location.onLocationChanged.listen((LocationData currentLocation) {
//     //   setState(() {

//     // UserLocation(
//     //         latitude: _currentPosition.latitude!.toDouble(),
//     //         longtitude: _currentPosition.longitude!.toDouble())
//     //     .locationName();

//     AuthController().saveLocation(_currentPosition.latitude!.toDouble(),
//         _currentPosition.latitude!.toDouble());

//     LocationService();
//   }

//   Future<UserLocation> getUserCurrentLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       _currentLocation = UserLocation(
//         latitude: userLocation.latitude!.toDouble(),
//         longtitude: userLocation.longitude!.toDouble(),
//       );
//     } catch (e) {}
//     return _currentLocation;
//   }
// }
