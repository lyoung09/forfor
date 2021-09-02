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
      body: Row(
        children: <Widget>[
          NavigationRail(
            groupAlignment: 1.0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
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
              ],
            ),
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 40),
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('홈'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 40),
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('포스팅'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 15),
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person_outline),
                label: Text('친구'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 15),
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble_outline),
                label: Text('그룹 채팅'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 15),
                icon: IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return BottomNavigation();
                        },
                      ),
                    );
                  },
                ),
                selectedIcon: Icon(Icons.arrow_back_ios_sharp),
                label: Text('exit'),
              )
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: _selectd(),
          )
        ],
      ),
    );
  }
}
