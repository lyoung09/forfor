import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/login/controller/bind/usercontroller.dart';
import 'package:get/get.dart';
import 'package:forfor/login/controller/bind/authcontroller.dart';
import 'package:forfor/model/userLocation.dart';
import 'package:location/location.dart';

class LocationService {
  late UserLocation _currentLocation;

  Location location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((event) {
          _locationController.add(UserLocation(
              latitude: event.latitude!.toDouble(),
              longtitude: event.longitude!.toDouble()));
          // print(controller.user!.uid);

          // if (controller.user!.uid.isNotEmpty) {
          //   FirebaseFirestore.instance
          //       .collection('users')
          //       .doc(controller.user!.uid)
          //       .update({
          //     'latitude': event.latitude!.toDouble(),
          //     'longtitude': event.longitude!.toDouble()
          //   });
          // }
        });
      } else {
        print("not allow userLocation");
      }
    });
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
