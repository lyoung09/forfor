import 'package:geocoder/geocoder.dart';

class UserLocation {
  double? latitude;
  double? longtitude;

  UserLocation({this.latitude, this.longtitude});

  saveUserLocation(uid) {
    if (uid != null) {}
  }

  Future<Address> locationName() async {
    print(this.latitude);
    print(this.longtitude);
    final coordinates = new Coordinates(this.latitude, this.longtitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.countryName} ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    return first;
  }
}
