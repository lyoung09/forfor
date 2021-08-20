import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userId() {
    try {
      String uid = _auth.currentUser?.uid ?? "";
      return uid;
    } catch (e) {
      return "${e}";
    }
  }
}
