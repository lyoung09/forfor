import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/model/userLocation.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  late UserLocation _currentLocation;

  Location location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((event) {
          _locationController.add(UserLocation(
              latitude: event.latitude!.toDouble(),
              longtitude: event.longitude!.toDouble()));
          // print(controller.user!.uid);
          GeoFirePoint myLocation = geo.point(
              latitude: event.latitude!.toDouble(),
              longitude: event.longitude!.toDouble());
        });
      } else {
        print("not allow userLocation");
      }
    });
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _currentPosition;
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
        return;
      }
    }

    _currentPosition = await location.getLocation();

    if (_currentLocation.latitude == null) {
      UserLocation(latitude: 12, longtitude: 12);
    } else {
      UserLocation(
          latitude: _currentPosition.latitude!.toDouble(),
          longtitude: _currentPosition.longitude!.toDouble());
    }
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_currentPosition.latitude == null) {
      prefs.setDouble("lat", 0.0);
      prefs.setDouble("lng", 0.0);
    } else {
      prefs.setDouble("lat", _currentPosition.latitude!.toDouble());
      prefs.setDouble("lng", _currentPosition.longitude!.toDouble());
    }
    //   });
    //   _firestore.collection('locations').doc(widget.uid).update({
    //     'latitude': myLocation.latitude,
    //     'longtitude': myLocation.longitude
    //   });
    // });
  }

  Future<UserLocation> getUserCurrentLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude!.toDouble(),
        longtitude: userLocation.longitude!.toDouble(),
      );
    } catch (e) {}
    return _currentLocation;
  }
}
