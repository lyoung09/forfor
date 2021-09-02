import 'package:flutter/material.dart';

class GroupHome extends StatefulWidget {
  const GroupHome({Key? key}) : super(key: key);

  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("1"),
          Text("1"),
          Text("1"),
          Text("1"),
          Text("1"),
          Text("1"),
          Text("1"),
          Text("1"),
        ],
      ),
    );
  }
}
