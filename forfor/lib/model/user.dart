import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? gender;
  String? nickname;
  String? url;
  String? country;

  UserModel(
      {this.id,
      this.email,
      this.gender,
      this.nickname,
      this.url,
      this.country});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot["email"];
    gender = documentSnapshot["gender"];
    nickname = documentSnapshot["nickname"];
    url = documentSnapshot["url"];
    country = documentSnapshot["country"];
  }
}
