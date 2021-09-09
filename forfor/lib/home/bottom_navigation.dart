import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:forfor/bottomScreen/buddy/buddy_main.dart';
import 'package:forfor/bottomScreen/buddy/invitePeopleScreen.dart';
import 'package:forfor/bottomScreen/chat/chat_main.dart';
import 'package:forfor/bottomScreen/group/group.dart';
import 'package:forfor/bottomScreen/infomation/sayScreen.dart';
import 'package:forfor/bottomScreen/infomation/timeline.dart';
import 'package:forfor/bottomScreen/profile/my_profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  //tabbar에 따라 움직이는 screen list
  List<Widget> _widgetOptions = <Widget>[
    //GroupCategoryMain(),
    Group(),
    ChatMainScreen(),
    InvitePersonScreen(),
    SayScreen(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.amberAccent,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.amberAccent,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors.grey[350], fontFamily: 'nanumB'))),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[350],
            currentIndex: _selectedIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icon/group.png",
                    fit: BoxFit.fill,
                    width: 25,
                    height: 25,
                  ),
                  label: "그룹"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/chattingBottom.svg",
                    fit: BoxFit.fill,
                    width: size.width * 0.25,
                    height: size.height * 0.04,
                  ),
                  label: "채팅"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/friendBottom.svg",
                    fit: BoxFit.fill,
                    width: size.width * 0.25,
                    height: size.height * 0.04,
                  ),
                  label: "친구"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icon/question.png",
                    fit: BoxFit.fill,
                    width: 25,
                    height: 25,
                  ),
                  label: "QnA"),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/profileBottom.svg",
                  fit: BoxFit.fill,
                  width: size.width * 0.25,
                  height: size.height * 0.04,
                ),
                label: '프로필',
              )
            ],
            unselectedLabelStyle: TextStyle(fontSize: 14),
            selectedLabelStyle: TextStyle(
              fontSize: 18,
            ),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
