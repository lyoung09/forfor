import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String _nickname;
  String _url;
  String _country;

  UserData(this._nickname, this._url, this._country);

  String get nickname => _nickname;
  String get url => _url;
  String get country => _country;

  FirebaseAuth auth = FirebaseAuth.instance;
  String get userId => auth.currentUser!.uid;
}

class UserInf {
  UserInf({required this.uid});
  final String? uid;

  String? get getUserId {
    return this.uid;
  }
}
