// import 'package:geocoder/geocoder.dart';

// class UserLocation {
//   double? latitude;
//   double? longtitude;

//   UserLocation({this.latitude, this.longtitude});

//   saveUserLocation(uid) {
//     if (uid != null) {}
//   }

//   Future<Address> locationName() async {
//     final coordinates = new Coordinates(this.latitude, this.longtitude);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var first = addresses.first;

//     print('${first.locality} ${first.countryName} ');

//     return first;
//   }
//}
