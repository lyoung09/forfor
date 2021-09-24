import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  buttonLogin() async {
    final email = _usernameControl.text.trim();
    final password = _passwordControl.text.trim();

    // FirebaseAuth _auth = FirebaseAuth.instance;
    // await _auth.signInWithEmailAndPassword(email: email, password: password);
    // QuerySnapshot snap = await FirebaseFirestore.instance
    //     .collection("users")
    //     .where("email", isEqualTo: email)
    //     .where("password", isEqualTo: password)
    //     .get();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BottomNavigation();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
