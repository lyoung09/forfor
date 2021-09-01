import 'package:flutter/material.dart';
import 'package:forfor/home/bottom_navigation.dart';
import 'package:navigation_rail/navigation_rail.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int _selectedIndex = 0;

  Widget firstScreen() {
    return Column(
      children: [
        Text("hoit"),
        Text("hoit"),
        Text("hoit"),
        Text("hoit"),
      ],
    );
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
                label: Text('First'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 15),
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Second'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 15),
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('그룹채팅'),
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
                selectedIcon: Icon(Icons.chat_bubble_outline_outlined),
                label: Text('exit'),
              )
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Column(
              children: [
                if (_selectedIndex == 0) Text("tk"),
                if (_selectedIndex == 1) firstScreen(),
                if (_selectedIndex == 2) Text("2"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
