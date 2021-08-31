import 'package:flutter/material.dart';
import 'package:forfor/widget/img.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_strings.dart';

class GcategoryMenuScreen extends StatefulWidget {
  const GcategoryMenuScreen({Key? key}) : super(key: key);

  @override
  _GcategoryMenuScreenState createState() => _GcategoryMenuScreenState();
}

class _GcategoryMenuScreenState extends State<GcategoryMenuScreen> {
  List<Data> dataList = [];
  final TextEditingController _filter = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // dataList.add(Data(Colors.amber, 'Amelia Brown',
    //     'Life would be a great deal easier if dead things had the decency to remain dead.'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              alignment: Alignment.bottomCenter,
              constraints: BoxConstraints.expand(height: 80),
              child: Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.search, color: Colors.grey[600]),
                        onPressed: () {
                          _filter.clear();
                          setState(() {});
                        }),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        controller: _filter,
                        style: TextStyle(color: Colors.grey[600], fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Locations',
                          hintStyle: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemBuilder: (builder, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/dummy/image_4.jpg',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Phasellus a Turpis id Nisi",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.grey[800]),
                              ),
                              Container(height: 10),
                              Container(
                                child: Text(MyStrings.middle_lorem_ipsum,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700])),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.transparent),
                              child: Text(
                                "SHARE",
                                style: TextStyle(color: MyColors.accent),
                              ),
                              onPressed: () {},
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.transparent),
                              child: Text(
                                "EXPLORE",
                                style: TextStyle(color: MyColors.accent),
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Container(height: 5)
                      ],
                    ),
                  );
                },
                separatorBuilder: (builder, index) {
                  return Divider(
                    height: 10,
                    thickness: 0,
                  );
                },
                itemCount: 20),
          ),
        ],
      ),
    );
  }
}

class Data {
  MaterialColor color;
  String name;
  String detail;

  Data(this.color, this.name, this.detail);
}
