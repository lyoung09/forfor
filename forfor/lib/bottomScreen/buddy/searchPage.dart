import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool expandedUserList = false;
  String name = "";
  checkUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Expanded(
              flex: 2,
              child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
            ),
            Expanded(
                flex: 8,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.black,
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        decoration: InputDecoration(
                          // prefixIcon: IconButton(
                          //   icon: Icon(Icons.search),
                          //   onPressed: () {
                          //     print(_searchController.text);
                          //   },
                          // ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          hintText: 'Search People',
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                )),
            // Expanded(
            //   flex: 2,
            //   child: Align(
            //       alignment: Alignment.topRight,
            //       child: IconButton(
            //           icon: Icon(Icons.search),
            //           color: Colors.black,
            //           onPressed: checkUser)),
            // ),
          ],
        ),
        body: (name == "" && name.isEmpty)
            ? Container(
                child: Center(
                    child:
                        Text("${name}", style: TextStyle(color: Colors.black))),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    //.where("nickname", isGreaterThanOrEqualTo: name)
                    .where('nickname', isGreaterThanOrEqualTo: name)
                    .where('nickname', isLessThan: name + 'z')

                    //.startAt([name])
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("");
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      print(document);
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return OtherProfile(
                                    uid: data["uid"],
                                    userName: data["nickname"],
                                    userImage: data["url"],
                                    introduction: data["introduction"]);
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              //                    <--- top side
                              color: Colors.black,
                              width: 0.3,
                            ),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              Expanded(
                                flex: 2,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage("${data['url']}")),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 45,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'icons/flags/png/${data['country']}.png',
                                            package: 'country_icons'),
                                        backgroundColor: Colors.white,
                                        radius: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      data['nickname'],
                                      // "userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']userData.data!.docs[index]['nickname']",

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 3.0),
                                    child: Text(
                                      "${data['address']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }));
  }
}
