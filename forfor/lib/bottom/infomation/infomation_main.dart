import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InformationMainScreen extends StatefulWidget {
  const InformationMainScreen({Key? key}) : super(key: key);

  @override
  _InformationMainScreenState createState() => _InformationMainScreenState();
}

class _InformationMainScreenState extends State<InformationMainScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initState() {
    super.initState();
    userInformation();
  }

  userInformation() {
    print(auth.currentUser?.uid);
  }

  CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('category');

  userWantsCategory() {}

  Widget _category(data) {
    return FutureBuilder(
      future: categoryRef.where("categoryId", whereIn: [
        data["category1"],
        data["category2"],
        data["category3"]
      ]).get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> categoryData) {
        if (!categoryData.hasData) {
          return Text("Loading..");
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categoryData.data!.docs.length,
            itemBuilder: (context, position) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10),
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      child: InkWell(
                          child: SizedBox(
                            width: 85,
                            height: 85,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 8.0, bottom: 1.0),
                                ),
                                Image.network(
                                  categoryData.data!.docs[position]
                                      ["categoryImage"],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fitHeight,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                ),
                                Text(
                                  categoryData.data!.docs[position]
                                      ["categoryName"],
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                          onTap: () {}),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _bestInformation() {
    return Text("");
  }

  Widget _categoryListInformation() {
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('users').doc(auth.currentUser?.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        }

        print("${snapshot.data!['category1']}");
        print("${snapshot.data!['category2']}");
        print("${snapshot.data!['category3']}");

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8.0),
                child: _category(snapshot.data),

                //),
              ),
              Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8.0),
                child: _bestInformation(),

                //),
              ),
              Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8.0),
                child: _categoryListInformation(),

                //),
              ),
            ],
          ),
        );
      },
    );
  }
}
