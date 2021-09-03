import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';

import 'groupPosting.dart';

class GroupHome extends StatefulWidget {
  const GroupHome({Key? key}) : super(key: key);

  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  Widget groupHome() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: groupHome(),
    );
  }
}
