import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? gender;
  String? nickname;
  String? url;
  String? country;
  String? access;
  String? timeStamp;
  String? introduction;
  String? deviceId;
  String? address;
  double? lat;
  double? lng;
  List<dynamic>? category;

  UserModel(
      {this.id,
      this.email,
      this.gender,
      this.nickname,
      this.url,
      this.country,
      this.deviceId,
      this.access,
      this.category,
      this.timeStamp,
      this.introduction,
      this.address,
      this.lat,
      this.lng});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot["email"];
    gender = documentSnapshot["gender"];
    nickname = documentSnapshot["nickname"];
    url = documentSnapshot["url"];
    country = documentSnapshot["country"];
    access = documentSnapshot["access"];
    category = documentSnapshot["category"];
    timeStamp = documentSnapshot["timeStamp"];
    introduction = documentSnapshot["introduction"];
    //deviceId = documentSnapshot["deviceId"];
    lat = documentSnapshot["lat"].toDouble();
    lng = documentSnapshot["lng"].toDouble();
    address = documentSnapshot["address"];
  }
}
