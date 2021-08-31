import 'package:flutter/material.dart';

class GcategoryMenuWidget extends StatelessWidget {
  final Function(String)? onItemClick;

  const GcategoryMenuWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 30,
              // ),
              // CircleAvatar(
              //   radius: 65,
              //   backgroundColor: Colors.grey,
              //   child: CircleAvatar(
              //     radius: 60,
              //     backgroundImage: AssetImage('assets/images/user_profile.jpg'),
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Nick',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 30,
              //       fontFamily: 'BalsamiqSans'),
              //),
              SizedBox(
                height: 20,
              ),
              sliderItem('MY', Icons.home),
              SizedBox(
                height: 10,
              ),
              sliderItem('Category1', Icons.category),
              SizedBox(
                height: 20,
              ),
              sliderItem('Category2', Icons.notifications_active),
              SizedBox(
                height: 20,
              ),
              sliderItem('Category3', Icons.favorite),
              SizedBox(
                height: 20,
              ),

              sliderItem('adding group', Icons.add_circle),
              SizedBox(
                height: 20,
              ),
              sliderItem('fileter\nLike,posting', Icons.arrow_back_ios)
            ],
          ),
        ),
      ],
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
            TextStyle(color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        icons,
        color: Colors.black,
      ),
      onTap: () {
        onItemClick!(title);
      });
}
