import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/group/groupPage/groupchatting.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:navigation_rail/navigation_rail.dart';

import 'groupPage/groupFriend.dart';
import 'groupPage/groupHome.dart';
import 'groupPage/groupPosting.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int _selectedIndex = 0;
  bool close = false;
  late BuildContext _scaffoldCtx;

  initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), () {
        Scaffold.of(_scaffoldCtx).openDrawer();
      });
    });
    super.initState();
  }

  Widget _selectd() {
    if (_selectedIndex == 0)
      return GroupHome();
    else if (_selectedIndex == 1)
      return GroupPosting();
    else if (_selectedIndex == 2)
      return GroupFriend();
    else if (_selectedIndex == 3)
      return GroupChatting();
    else
      return GroupHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          leading: IconButton(
              icon: Icon(Icons.reorder),
              iconSize: 30,
              color: Colors.black,
              onPressed: () {
                Scaffold.of(_scaffoldCtx).openDrawer();
              }),
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        _scaffoldCtx = context;
        return Row(
          children: <Widget>[
        
            Expanded(
              child: _selectd(),
            )
          ],
        );
      }),
      drawer: Container(
        width: 120,
        padding: EdgeInsets.only(left: 20, top: 40),
        child: Drawer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("assets/images/man2.jpg"),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text("Home", style: TextStyle(fontSize: 25)),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[500],
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text("Posting", style: TextStyle(fontSize: 25)),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[500],
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text("friend", style: TextStyle(fontSize: 25)),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[500],
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text("group chatting"),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              Spacer(),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text("group chatting"),
                  ],
                ),
                onTap: () {
                  //Navigator.of(context).pop;
                },
              ),
            ])),
      ),
    );
  }
}
