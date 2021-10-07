import 'package:geocoder/geocoder.dart';

class UserLocation {
  final double latitude;
  final double longtitude;

  UserLocation({required this.latitude, required this.longtitude});

  saveUserLocation(uid) {
    if (uid != null) {}
  }

  Future<Address> locationName() async {
    final coordinates = new Coordinates(this.latitude, this.longtitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    return first;
  }
}
