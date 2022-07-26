import 'package:flutter/material.dart';
import 'package:wtom/screen/cryptalk/crypalk.dart';
import 'package:wtom/screen/news/news.dart';
import 'package:wtom/screen/profile/profile.dart';
import 'package:wtom/settings/theme/themes.dart';
import 'package:wtom/utils/my_text.dart';

class BottomNavigationTabScreen extends StatefulWidget {
  const BottomNavigationTabScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationTabScreen> createState() =>
      _BottomNavigationTabScreenState();
}

class _BottomNavigationTabScreenState extends State<BottomNavigationTabScreen> {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions = [
    const CryptalkScreen(),
    const NewsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          body: widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Theme(
            data: Themes().lightThemes,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              //type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey[350],
              currentIndex: _selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                    icon:
                        // Badge(
                        //   child:
                        Image.asset(
                      "assets/icon/coin.png",
                      fit: BoxFit.fill,
                      width: 25,
                      height: 25,
                    ),
                    //),
                    label: "home"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icon/crypto.png",
                      fit: BoxFit.fill,
                      width: 25,
                      height: 25,
                    ),
                    label: "News"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/icon/user.png",
                      fit: BoxFit.fill,
                      width: 25,
                      height: 25,
                    ),
                    label: "My"),
              ],
              unselectedLabelStyle: MyText.body2(context),
              selectedLabelStyle: MyText.body1(context),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
}
