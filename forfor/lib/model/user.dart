import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? gender;
  String? nickname;
  String? url;
  String? country;
  String? access;
  List<dynamic>? category;
  UserModel(
      {this.id,
      this.email,
      this.gender,
      this.nickname,
      this.url,
      this.country,
      this.access,
      this.category});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot["email"];
    gender = documentSnapshot["gender"];
    nickname = documentSnapshot["nickname"];
    url = documentSnapshot["url"];
    country = documentSnapshot["country"];
    access = documentSnapshot["access"];
    category = documentSnapshot["category"];
  }
}
