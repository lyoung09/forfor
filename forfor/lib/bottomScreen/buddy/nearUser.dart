import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/model/userLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:rxdart/rxdart.dart';

// class NearUser extends StatefulWidget {
//   final String uid;
//   final double lat;
//   final double lng;
//   NearUser({required this.uid, required this.lat, required this.lng});
//   @override
//   _NearUserState createState() => _NearUserState();
// }

// class _NearUserState extends State<NearUser> {
//   late TextEditingController _latitudeController, _longitudeController;
//   Location location = Location();

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   // firestore init
//   final _firestore = FirebaseFirestore.instance;
//   late Geoflutterfire geo;
//   late Stream<List<DocumentSnapshot>> stream;
//   final radius = BehaviorSubject<double>.seeded(1.0);
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   GoogleMapController? _mapController;
//   late LocationData _currentPosition;
//   late GeoFirePoint myLocation;
//   late GeoFirePoint center;
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
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       setState(() {
//         myLocation = geo.point(
//             latitude: currentLocation.latitude!.toDouble(),
//             longitude: currentLocation.longitude!.toDouble());
//       });
//       _firestore.collection('locations').doc(widget.uid).update({
//         'latitude': myLocation.latitude,
//         'longtitude': myLocation.longitude
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _latitudeController = TextEditingController();
//     _longitudeController = TextEditingController();

//     getLoc();
//     geo = Geoflutterfire();
//     if (myLocation.data == null) {
//     } else {
//       GeoFirePoint center = geo.point(
//           latitude: myLocation.latitude, longitude: myLocation.longitude);
//       stream = radius.switchMap((rad) {
//         var collectionReference = _firestore.collection('locations');
// //          .where('name', isEqualTo: 'darshan');
//         return geo.collection(collectionRef: collectionReference).within(
//             center: center, radius: rad, field: 'position', strictMode: true);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _latitudeController.dispose();
//     _longitudeController.dispose();
//     radius.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: Card(
//               elevation: 4,
//               margin: EdgeInsets.symmetric(vertical: 8),
//               child: SizedBox(
//                 width: mediaQuery.size.width - 30,
//                 height: mediaQuery.size.height * (1 / 3),
//                 child: GoogleMap(
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: const CameraPosition(
//                     target: LatLng(12.960632, 77.641603),
//                     zoom: 15.0,
//                   ),
//                   markers: Set<Marker>.of(markers.values),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Slider(
//               min: 1,
//               max: 200,
//               divisions: 4,
//               value: _value,
//               label: _label,
//               activeColor: Colors.blue,
//               inactiveColor: Colors.blue.withOpacity(0.2),
//               onChanged: (double value) => changed(value),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Container(
//                 width: 100,
//                 child: TextField(
//                   controller: _latitudeController,
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                       labelText: 'lat',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       )),
//                 ),
//               ),
//               Container(
//                 width: 100,
//                 child: TextField(
//                   controller: _longitudeController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       labelText: 'lng',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       )),
//                 ),
//               ),
//               MaterialButton(
//                 color: Colors.blue,
//                 onPressed: () {
//                   final lat = double.parse(_latitudeController.text);
//                   final lng = double.parse(_longitudeController.text);
//                   _addPoint(lat, lng);
//                 },
//                 child: const Text(
//                   'ADD',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//           MaterialButton(
//             color: Colors.amber,
//             child: const Text(
//               'Add nested ',
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               final lat = double.parse(_latitudeController.text);
//               final lng = double.parse(_longitudeController.text);
//               _addNestedPoint(lat, lng);
//             },
//           )
//         ],
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _mapController = controller;
// //      _showHome();
//       //start listening after map is created
//       stream.listen((List<DocumentSnapshot> documentList) {
//         _updateMarkers(documentList);
//       });
//     });
//   }

//   void _showHome() {
//     _mapController!.animateCamera(CameraUpdate.newCameraPosition(
//       const CameraPosition(
//         target: LatLng(12.960632, 77.641603),
//         zoom: 15.0,
//       ),
//     ));
//   }

//   void _addPoint(double lat, double lng) {
//     GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
//     _firestore
//         .collection('locations')
//         .add({'name': 'random name', 'position': geoFirePoint.data}).then((_) {
//       print('added ${geoFirePoint.hash} successfully');
//     });
//   }

//   //example to add geoFirePoint inside nested object
//   void _addNestedPoint(double lat, double lng) {
//     GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
//     _firestore.collection('nestedLocations').add({
//       'name': 'random name',
//       'address': {
//         'location': {'position': geoFirePoint.data}
//       }
//     }).then((_) {
//       print('added ${geoFirePoint.hash} successfully');
//     });
//   }

//   void _addMarker(double lat, double lng) {
//     final id = MarkerId(lat.toString() + lng.toString());
//     final _marker = Marker(
//       markerId: id,
//       position: LatLng(lat, lng),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
//       infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
//     );
//     setState(() {
//       markers[id] = _marker;
//     });
//   }

//   void _updateMarkers(List<DocumentSnapshot> documentList) {
//     documentList.forEach((DocumentSnapshot document) {
//       //var latitude =document.data()['position']['geopoint'] ;

//       //final GeoPoint point = document.data()["distance"];

//       //_addMarker(point.latitude, point.longitude);
//     });
//   }

//   double _value = 20.0;
//   String _label = '';

//   changed(value) {
//     setState(() {
//       _value = value;
//       _label = '${_value.toInt().toString()} kms';
//       markers.clear();
//     });
//     radius.add(value);
//   }
// }

class DistanceUser extends StatefulWidget {
  final String uid;
  final double lat;
  final double lng;
  const DistanceUser(
      {Key? key, required this.uid, required this.lat, required this.lng})
      : super(key: key);

  @override
  DistancerUserState createState() => DistancerUserState();
}

class DistancerUserState extends State<DistanceUser> {
  late List<int> sortedKeys;
  late LinkedHashMap sortedMap;
  Location location = Location();

  final _firestore = FirebaseFirestore.instance;
  Map<int, String> distanceUser = new Map();

  initState() {
    super.initState();
    print(widget.lat);
    print(widget.lng);
  }

  //현재 위치와 가게 위치 거리 구하는메소드
  String _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return ((12742 * asin(sqrt(a)) * 1000)).toStringAsFixed(0);
  }

  final userDistance = FirebaseFirestore.instance.collection('users');
  late Stream<List<DocumentSnapshot>> stream;

  Future<QuerySnapshot> getUserDistancefuture() async {
    final distance = await FirebaseFirestore.instance.collection('users')
        //.where("uid", isNotEqualTo: widget.uid)
        .where("lat", whereNotIn: [-1, widget.lat]).get();

    ////////////streambuilder example/////
    // print(distance.runtimeType);
    // print(distance.forEach((QuerySnapshot element) {
    //   for (int i = 0; i < element.size;i++)
    //     distanceUser[element.docs[i]["uid"]] = _coordinateDistance(widget.lat,
    //         widget.lng, element.docs[i]["lat"], element.docs[i]["lng"]);
    //   print(element.docs[0]["uid"]);
    // }));

    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDistancefuture(),
        builder: (context, AsyncSnapshot<QuerySnapshot> userData) {
          if (!userData.hasData) {
            return Text("");
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: userData.data!.size,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(4),
              itemBuilder: (BuildContext context, int index) {
                // if (userData.data!.docs[index]["uid"] == uid) {
                //   return Container(height: 0, width: 0, child: Text("hello"));
                // }

                for (int i = 0; i < userData.data!.size; i++) {
                  distanceUser[i] = _coordinateDistance(
                      widget.lat,
                      widget.lng,
                      userData.data!.docs[i]["lat"],
                      userData.data!.docs[i]["lng"]);
                }

                var sortedKeys = distanceUser.keys.toList(growable: false)
                  ..sort((k1, k2) => int.parse(distanceUser[k1]!)
                      .compareTo(int.parse(distanceUser[k2]!)));
                final List<int> category = userData
                    .data!.docs[sortedKeys[index]]["category"]
                    .cast<int>();

                sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
                    key: (k) => k, value: (k) => distanceUser[k]);

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OtherProfile(
                              uid: userData.data!.docs[sortedKeys[index]]
                                  ["uid"],
                              userName: userData.data!.docs[sortedKeys[index]]
                                  ["nickname"],
                              userImage: userData.data!.docs[sortedKeys[index]]
                                  ["url"],
                              introduction: userData.data!
                                  .docs[sortedKeys[index]]["introduction"],
                              country: userData.data!.docs[sortedKeys[index]]
                                  ["country"],
                              address: userData.data!.docs[sortedKeys[index]]
                                  ["address"]);
                        },
                      ),
                    );

                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return CustomDialogBox(
                    //         title: "${userData.data!.docs[index]["nickname"]}",
                    //         descriptions: userData.data!.docs[index]
                    //             ["category"],
                    //         img: '${userData.data!.docs[index]["url"]}',
                    //         text: "Yes",
                    //       );
                    //     });
                  },
                  child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "${userData.data!.docs[sortedKeys[index]]['url']}")),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 40,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'icons/flags/png/${userData.data!.docs[sortedKeys[index]]['country']}.png',
                                      package: 'country_icons'),
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 5, top: 8),
                                  child: Text(
                                    userData.data!.docs[sortedKeys[index]]
                                        ['nickname'],
                                    // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('category')
                                          .where('categoryId', whereIn: [
                                        for (int i = 0;
                                            i <
                                                userData
                                                    .data!
                                                    .docs[sortedKeys[index]]
                                                        ['category']
                                                    .length;
                                            i++)
                                          category[i]
                                      ]).snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              categorySnapshot) {
                                        if (!categorySnapshot.hasData) {
                                          return Text("");
                                        }
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                categorySnapshot.data!.size,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Transform(
                                                transform:
                                                    new Matrix4.identity()
                                                      ..scale(0.8),
                                                child: Chip(
                                                  backgroundColor:
                                                      Colors.orange[50],
                                                  label: Text(
                                                      categorySnapshot
                                                              .data!.docs[index]
                                                          ["categoryName"],
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              );
                                            });
                                      })),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, left: 5, bottom: 2),
                                  child: Text(
                                    userData.data!.docs[sortedKeys[index]]
                                            ['introduction'] ??
                                        "",
                                    //"userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],userData.data!.docs[index]['email'],",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userData.data!.docs[sortedKeys[index]]
                                        ['address'],
                                    // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 3.0),
                                  child: Text(
                                    double.parse(sortedMap[sortedKeys[index]]) >
                                            100000
                                        ? ""
                                        : double.parse(sortedMap[
                                                        sortedKeys[index]]) *
                                                    0.001 <
                                                100.0
                                            ? "바로 주변"
                                            : "${(double.parse(sortedMap[sortedKeys[index]]) * 0.001).toStringAsFixed(1)}km",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
