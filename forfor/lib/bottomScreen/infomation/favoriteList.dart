import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';

class FavoriteUser extends StatefulWidget {
  final List userId;
  const FavoriteUser({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _FavoriteUserState createState() => _FavoriteUserState();
}

class _FavoriteUserState extends State<FavoriteUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10),
            child: Text(
              "좋아요",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              iconSize: 22,
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where("uid", whereIn: widget.userId)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, count) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return OtherProfile(
                                uid: snapshot.data!.docs[count]["uid"],
                                userName: snapshot.data!.docs[count]
                                    ["nickname"],
                                userImage: snapshot.data!.docs[count]["url"],
                                introduction: snapshot.data!.docs[count]
                                    ["introduction"],
                                country: snapshot.data!.docs[count]["country"],
                                address: snapshot.data!.docs[count]["address"]);
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          margin: EdgeInsets.all(0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                              "${snapshot.data!.docs[count]["url"]}")),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 5,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'icons/flags/png/${snapshot.data!.docs[count]["country"]}.png',
                                            package: 'country_icons'),
                                        backgroundColor: Colors.white,
                                        radius: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 13.0),
                                        child: Text(
                                            "${snapshot.data!.docs[count]["nickname"]}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.5,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('category')
                                                .where('categoryId',
                                                    whereIn: snapshot
                                                            .data!.docs[count]
                                                        ["category"])
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    category) {
                                              if (!category.hasData) {
                                                return Container();
                                              }

                                              return ListView.builder(
                                                  shrinkWrap: false,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      category.data!.size,
                                                  itemBuilder:
                                                      (context, categoryNum) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Chip(
                                                        label: Text(
                                                          "${category.data!.docs[categoryNum]["categoryName"]}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.orange[50],
                                                        elevation: 6.0,
                                                      ),
                                                    );
                                                  });
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    ),
                  );
                });
          }),
    );
  }
}
