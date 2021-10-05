import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  const UserProfile({Key? key, required this.uid}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

//1.친구  ==> 다 볼수있게 --> 사진 밑에 소개 밑에 카테고리, 모든 그룹 포스팅 , QnA // 초대하기 버튼(내가 그룹있다면),메세지버튼
//2.그룹친구 ==>  사진 밑에 소개 밑에 카테고리 및 그룹 포스팅 및 QnA// 초대하기 버튼(내가 그룹있다면),메세지버튼(거절 되 ㅇㅆ으면 안되겟징)
//3.남 ==> 다 볼수있게 --> 사진 밑에 소개 밑에 카테고리 QnA// 초대하기 버튼(내가 그룹있다면),메세지버튼
class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      // Do whatever you want based on the tab index
    });

    super.initState();
  }

  // Widget silverappBar() {
  //   return Container(
  //       child: Column(children: [
  //     SizedBox(
  //       height: 100,
  //     ),
  //     Container(
  //       decoration: BoxDecoration(
  //           color: Colors.orange[50],
  //           borderRadius: BorderRadius.all(Radius.circular(20))),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                   padding: EdgeInsets.only(
  //                       left: MediaQuery.of(context).size.width * 0.1)),
  //               snapshot.data!["url"] == null
  //                   ? Expanded(
  //                       flex: 3,
  //                       child: Container(
  //                         alignment: Alignment.topLeft,
  //                         width: MediaQuery.of(context).size.width * 0.25,
  //                         child: CircleAvatar(
  //                             radius: 45,
  //                             backgroundColor: Colors.grey[400],
  //                             child: Icon(Icons.person, size: 50)),
  //                       ),
  //                     )
  //                   : Expanded(
  //                       flex: 3,
  //                       child: Container(
  //                         child: CircleAvatar(
  //                           radius: 45,
  //                           backgroundColor: Colors.white,
  //                           backgroundImage:
  //                               NetworkImage(snapshot.data!["url"] ?? ""),
  //                         ),
  //                       ),
  //                     ),
  //               Padding(
  //                   padding: EdgeInsets.only(
  //                       left: MediaQuery.of(context).size.width * 0.06)),
  //               Expanded(
  //                 flex: 8,
  //                 child: Container(
  //                   alignment: Alignment.topLeft,
  //                   height: 135,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                         flex: 1,
  //                         child: Container(
  //                           child: Text(snapshot.data!['nickname'] ?? "User",
  //                               overflow: TextOverflow.ellipsis,
  //                               maxLines: 1,
  //                               style: TextStyle(fontSize: 33)),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         flex: 1,
  //                         child: Container(
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(5),
  //                             child: Text(snapshot.data!['category'].toString(),
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 1,
  //                                 style: TextStyle(fontSize: 15)),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         flex: 1,
  //                         child: Container(
  //                           height: 50,
  //                           margin: EdgeInsets.only(right: 5),
  //                           width: MediaQuery.of(context).size.width * 0.7,
  //                           child: FutureBuilder(
  //                               future: FirebaseFirestore.instance
  //                                   .collection("category")
  //                                   .where("categoryId", whereIn: [
  //                                 // for (int i = 0;
  //                                 //     i <
  //                                 //         category
  //                                 //             .length;
  //                                 //     i++)
  //                                 //   category[i]
  //                                 1,
  //                                 2,
  //                                 3,
  //                                 // 4,
  //                                 // 5,
  //                               ]).get(),
  //                               builder: (context,
  //                                   AsyncSnapshot<QuerySnapshot> categoryData) {
  //                                 if (categoryData.hasData) {
  //                                   return GridView.builder(
  //                                       gridDelegate:
  //                                           new SliverGridDelegateWithFixedCrossAxisCount(
  //                                               crossAxisCount: 3,

  //                                               // childAspectRatio: MediaQuery.of(
  //                                               //             context)
  //                                               //         .size
  //                                               //         .width /
  //                                               //     (MediaQuery.of(
  //                                               //                 context)
  //                                               //             .size
  //                                               //             .height /
  //                                               //         3),
  //                                               childAspectRatio: 180 / 100),
  //                                       itemCount: categoryData.data!.size,
  //                                       itemBuilder: (context, count) {
  //                                         return Chip(
  //                                             backgroundColor:
  //                                                 Colors.orange[50],
  //                                             // avatar: CircleAvatar(
  //                                             //     radius:
  //                                             //         100,
  //                                             //     backgroundColor:
  //                                             //         Colors.orange[
  //                                             //             50],
  //                                             //     backgroundImage: NetworkImage(categoryData
  //                                             //             .data!
  //                                             //             .docs[count]
  //                                             //         [
  //                                             //         "categoryImage"])),
  //                                             label: Text(
  //                                                 categoryData.data!.docs[count]
  //                                                     ["categoryName"]));
  //                                       });
  //                                 }
  //                                 return Text("");
  //                               }),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           //////////////////////
  //           //////////////////////
  //           ///////user vip////////
  //           /////////category 6////////
  //           //////////////////////
  //           //////////////////////
  //           // Row(
  //           //   crossAxisAlignment:
  //           //       CrossAxisAlignment.start,
  //           //   children: [
  //           //     Padding(
  //           //         padding: EdgeInsets.only(
  //           //             left: MediaQuery.of(context)
  //           //                     .size
  //           //                     .width *
  //           //                 0.01)),
  //           //     snapshot.user.url == null
  //           //         ? Expanded(
  //           //             flex: 3,
  //           //             child: Container(
  //           //               alignment: Alignment.topLeft,
  //           //               width: MediaQuery.of(context)
  //           //                       .size
  //           //                       .width *
  //           //                   0.25,
  //           //               child: CircleAvatar(
  //           //                   radius: 45,
  //           //                   backgroundColor:
  //           //                       Colors.grey[400],
  //           //                   child: Icon(Icons.person,
  //           //                       size: 50)),
  //           //             ),
  //           //           )
  //           //         : Expanded(
  //           //             flex: 3,
  //           //             child: Container(
  //           //               child: CircleAvatar(
  //           //                 radius: 45,
  //           //                 backgroundColor: Colors.white,
  //           //                 backgroundImage: NetworkImage(
  //           //                     snapshot.user.url ?? ""),
  //           //               ),
  //           //             ),
  //           //           ),
  //           //     Padding(
  //           //         padding: EdgeInsets.only(
  //           //             left: MediaQuery.of(context)
  //           //                     .size
  //           //                     .width *
  //           //                 0.03)),
  //           //     Expanded(
  //           //       flex: 8,
  //           //       child: Container(
  //           //         alignment: Alignment.topLeft,
  //           //         height: 165,
  //           //         child: Column(
  //           //           crossAxisAlignment:
  //           //               CrossAxisAlignment.start,
  //           //           children: [
  //           //             Container(
  //           //               child: Text(
  //           //                   snapshot.user.nickname ??
  //           //                       "User",
  //           //                   overflow:
  //           //                       TextOverflow.ellipsis,
  //           //                   maxLines: 1,
  //           //                   style: TextStyle(
  //           //                       fontSize: 33)),
  //           //             ),
  //           //             Container(
  //           //               child: Padding(
  //           //                 padding:
  //           //                     const EdgeInsets.all(5),
  //           //                 child: Text(
  //           //                     snapshot.user.category
  //           //                         .toString(),
  //           //                     overflow:
  //           //                         TextOverflow.ellipsis,
  //           //                     maxLines: 1,
  //           //                     style: TextStyle(
  //           //                         fontSize: 15)),
  //           //               ),
  //           //             ),
  //           //             Container(
  //           //               height: 90,
  //           //               width: MediaQuery.of(context)
  //           //                       .size
  //           //                       .width *
  //           //                   0.7,
  //           //               child: FutureBuilder(
  //           //                   future: FirebaseFirestore
  //           //                       .instance
  //           //                       .collection("category")
  //           //                       .where("categoryId",
  //           //                           whereIn: [
  //           //                         // for (int i = 0;
  //           //                         //     i <
  //           //                         //         category
  //           //                         //             .length;
  //           //                         //     i++)
  //           //                         //   category[i]
  //           //                         1,
  //           //                         2,
  //           //                         3,
  //           //                         4,
  //           //                         5,
  //           //                       ]).get(),
  //           //                   builder: (context,
  //           //                       AsyncSnapshot<
  //           //                               QuerySnapshot>
  //           //                           categoryData) {
  //           //                     if (categoryData
  //           //                         .hasData) {
  //           //                       print(categoryData
  //           //                               .data!.docs[0]
  //           //                           ['categoryName']);

  //           //                       return GridView.builder(
  //           //                           gridDelegate:
  //           //                               new SliverGridDelegateWithFixedCrossAxisCount(
  //           //                                   crossAxisCount:
  //           //                                       3,

  //           //                                   // childAspectRatio: MediaQuery.of(
  //           //                                   //             context)
  //           //                                   //         .size
  //           //                                   //         .width /
  //           //                                   //     (MediaQuery.of(
  //           //                                   //                 context)
  //           //                                   //             .size
  //           //                                   //             .height /
  //           //                                   //         3),
  //           //                                   childAspectRatio:
  //           //                                       180 /
  //           //                                           100),
  //           //                           itemCount:
  //           //                               categoryData
  //           //                                   .data!.size,
  //           //                           itemBuilder:
  //           //                               (context,
  //           //                                   count) {
  //           //                             return Chip(
  //           //                                 backgroundColor:
  //           //                                     Colors.orange[
  //           //                                         50],
  //           //                                 // avatar: CircleAvatar(
  //           //                                 //     radius:
  //           //                                 //         100,
  //           //                                 //     backgroundColor:
  //           //                                 //         Colors.orange[
  //           //                                 //             50],
  //           //                                 //     backgroundImage: NetworkImage(categoryData
  //           //                                 //             .data!
  //           //                                 //             .docs[count]
  //           //                                 //         [
  //           //                                 //         "categoryImage"])),
  //           //                                 label: Text(categoryData
  //           //                                         .data!
  //           //                                         .docs[count]
  //           //                                     [
  //           //                                     "categoryName"]));
  //           //                           });
  //           //                     }
  //           //                     return Text("??");
  //           //                   }),
  //           //             )
  //           //           ],
  //           //         ),
  //           //       ),
  //           //     )
  //           //   ],
  //           // ),
  //           // Padding(padding: EdgeInsets.only(top: 8)),
  //           Card(
  //             elevation: 3,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15),
  //               side: BorderSide(
  //                 color: Colors.black,
  //                 width: 1.0,
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(10),
  //                   height: 100,
  //                   width: MediaQuery.of(context).size.width * 0.85,
  //                   child: Text(snapshot.data!["introduction"] ?? "",

  //                       // "write yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourself",
  //                       maxLines: 5,
  //                       overflow: TextOverflow.ellipsis,
  //                       textAlign: TextAlign.start,
  //                       style:
  //                           //userModel.introduction == null

  //                           //  ?
  //                           TextStyle(color: Colors.black, fontSize: 12)
  //                       // : MyText.subhead(context)!
  //                       //     .copyWith(
  //                       //         color: Colors.grey[900])
  //                       ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 15,
  //           )
  //         ],
  //       ),
  //     )
  //   ]));
  // }
  var top = 0.0;
  c(height) {
    setState(() {
      top = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading"));
            }

            return DefaultTabController(
              length: 2, // This is the number of tabs.
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.orange[50],
                        flexibleSpace: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          top = constraints.biggest.height;

                          return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                //opacity: top == 175.0 ? 1.0 : 0.0,
                                opacity: 1.0,
                                child: Text(
                                  top.toString(),
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black),
                                )),

                            // title: Text("${snapshot.data!["nickname"]}",
                            //     style: TextStyle(color: Colors.black)),
                            background: Container(
                                decoration:
                                    BoxDecoration(color: Colors.orange[50]),
                                child: Column(children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: Icon(Icons.arrow_back_ios_sharp),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.1)),
                                            snapshot.data!["url"] == null
                                                ? Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: CircleAvatar(
                                                          radius: 45,
                                                          backgroundColor:
                                                              Colors.grey[400],
                                                          child: Icon(
                                                              Icons.person,
                                                              size: 50)),
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      child: CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor:
                                                            Colors.white,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                snapshot.data![
                                                                        "url"] ??
                                                                    ""),
                                                      ),
                                                    ),
                                                  ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06)),
                                            Expanded(
                                              flex: 8,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 135,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text(
                                                            snapshot.data![
                                                                    'nickname'] ??
                                                                "User",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 33)),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Text(
                                                              snapshot.data![
                                                                      'category']
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 50,
                                                        margin: EdgeInsets.only(
                                                            right: 5),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: FutureBuilder(
                                                            future: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "category")
                                                                .where(
                                                                    "categoryId",
                                                                    whereIn: [
                                                                  // for (int i = 0;
                                                                  //     i <
                                                                  //         category
                                                                  //             .length;
                                                                  //     i++)
                                                                  //   category[i]
                                                                  1,
                                                                  2,
                                                                  3,
                                                                  // 4,
                                                                  // 5,
                                                                ]).get(),
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    categoryData) {
                                                              if (categoryData
                                                                  .hasData) {
                                                                return GridView.builder(
                                                                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount: 3,

                                                                        // childAspectRatio: MediaQuery.of(
                                                                        //             context)
                                                                        //         .size
                                                                        //         .width /
                                                                        //     (MediaQuery.of(
                                                                        //                 context)
                                                                        //             .size
                                                                        //             .height /
                                                                        //         3),
                                                                        childAspectRatio: 180 / 100),
                                                                    itemCount: categoryData.data!.size,
                                                                    itemBuilder: (context, count) {
                                                                      return Chip(
                                                                          backgroundColor: Colors.orange[
                                                                              50],
                                                                          // avatar: CircleAvatar(
                                                                          //     radius:
                                                                          //         100,
                                                                          //     backgroundColor:
                                                                          //         Colors.orange[
                                                                          //             50],
                                                                          //     backgroundImage: NetworkImage(categoryData
                                                                          //             .data!
                                                                          //             .docs[count]
                                                                          //         [
                                                                          //         "categoryImage"])),
                                                                          label: Text(categoryData
                                                                              .data!
                                                                              .docs[count]["categoryName"]));
                                                                    });
                                                              }
                                                              return Text("");
                                                            }),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        //////////////////////
                                        //////////////////////
                                        ///////user vip////////
                                        /////////category 6////////
                                        //////////////////////
                                        //////////////////////
                                        // Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Padding(
                                        //         padding: EdgeInsets.only(
                                        //             left: MediaQuery.of(context)
                                        //                     .size
                                        //                     .width *
                                        //                 0.01)),
                                        //     snapshot.user.url == null
                                        //         ? Expanded(
                                        //             flex: 3,
                                        //             child: Container(
                                        //               alignment: Alignment.topLeft,
                                        //               width: MediaQuery.of(context)
                                        //                       .size
                                        //                       .width *
                                        //                   0.25,
                                        //               child: CircleAvatar(
                                        //                   radius: 45,
                                        //                   backgroundColor:
                                        //                       Colors.grey[400],
                                        //                   child: Icon(Icons.person,
                                        //                       size: 50)),
                                        //             ),
                                        //           )
                                        //         : Expanded(
                                        //             flex: 3,
                                        //             child: Container(
                                        //               child: CircleAvatar(
                                        //                 radius: 45,
                                        //                 backgroundColor: Colors.white,
                                        //                 backgroundImage: NetworkImage(
                                        //                     snapshot.user.url ?? ""),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //     Padding(
                                        //         padding: EdgeInsets.only(
                                        //             left: MediaQuery.of(context)
                                        //                     .size
                                        //                     .width *
                                        //                 0.03)),
                                        //     Expanded(
                                        //       flex: 8,
                                        //       child: Container(
                                        //         alignment: Alignment.topLeft,
                                        //         height: 165,
                                        //         child: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             Container(
                                        //               child: Text(
                                        //                   snapshot.user.nickname ??
                                        //                       "User",
                                        //                   overflow:
                                        //                       TextOverflow.ellipsis,
                                        //                   maxLines: 1,
                                        //                   style: TextStyle(
                                        //                       fontSize: 33)),
                                        //             ),
                                        //             Container(
                                        //               child: Padding(
                                        //                 padding:
                                        //                     const EdgeInsets.all(5),
                                        //                 child: Text(
                                        //                     snapshot.user.category
                                        //                         .toString(),
                                        //                     overflow:
                                        //                         TextOverflow.ellipsis,
                                        //                     maxLines: 1,
                                        //                     style: TextStyle(
                                        //                         fontSize: 15)),
                                        //               ),
                                        //             ),
                                        //             Container(
                                        //               height: 90,
                                        //               width: MediaQuery.of(context)
                                        //                       .size
                                        //                       .width *
                                        //                   0.7,
                                        //               child: FutureBuilder(
                                        //                   future: FirebaseFirestore
                                        //                       .instance
                                        //                       .collection("category")
                                        //                       .where("categoryId",
                                        //                           whereIn: [
                                        //                         // for (int i = 0;
                                        //                         //     i <
                                        //                         //         category
                                        //                         //             .length;
                                        //                         //     i++)
                                        //                         //   category[i]
                                        //                         1,
                                        //                         2,
                                        //                         3,
                                        //                         4,
                                        //                         5,
                                        //                       ]).get(),
                                        //                   builder: (context,
                                        //                       AsyncSnapshot<
                                        //                               QuerySnapshot>
                                        //                           categoryData) {
                                        //                     if (categoryData
                                        //                         .hasData) {
                                        //                       print(categoryData
                                        //                               .data!.docs[0]
                                        //                           ['categoryName']);

                                        //                       return GridView.builder(
                                        //                           gridDelegate:
                                        //                               new SliverGridDelegateWithFixedCrossAxisCount(
                                        //                                   crossAxisCount:
                                        //                                       3,

                                        //                                   // childAspectRatio: MediaQuery.of(
                                        //                                   //             context)
                                        //                                   //         .size
                                        //                                   //         .width /
                                        //                                   //     (MediaQuery.of(
                                        //                                   //                 context)
                                        //                                   //             .size
                                        //                                   //             .height /
                                        //                                   //         3),
                                        //                                   childAspectRatio:
                                        //                                       180 /
                                        //                                           100),
                                        //                           itemCount:
                                        //                               categoryData
                                        //                                   .data!.size,
                                        //                           itemBuilder:
                                        //                               (context,
                                        //                                   count) {
                                        //                             return Chip(
                                        //                                 backgroundColor:
                                        //                                     Colors.orange[
                                        //                                         50],
                                        //                                 // avatar: CircleAvatar(
                                        //                                 //     radius:
                                        //                                 //         100,
                                        //                                 //     backgroundColor:
                                        //                                 //         Colors.orange[
                                        //                                 //             50],
                                        //                                 //     backgroundImage: NetworkImage(categoryData
                                        //                                 //             .data!
                                        //                                 //             .docs[count]
                                        //                                 //         [
                                        //                                 //         "categoryImage"])),
                                        //                                 label: Text(categoryData
                                        //                                         .data!
                                        //                                         .docs[count]
                                        //                                     [
                                        //                                     "categoryName"]));
                                        //                           });
                                        //                     }
                                        //                     return Text("??");
                                        //                   }),
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // Padding(padding: EdgeInsets.only(top: 8)),
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                height: 100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                child: Text(
                                                    snapshot.data![
                                                            "introduction"] ??
                                                        "",

                                                    // "write yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourself",
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        //userModel.introduction == null

                                                        //  ?
                                                        TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12)
                                                    // : MyText.subhead(context)!
                                                    //     .copyWith(
                                                    //         color: Colors.grey[900])
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                ])),
                          );
                        }),
                        pinned: true,
                        expandedHeight: 380.0,
                        //snap: true,
                        forceElevated: innerBoxIsScrolled,
                        bottom: TabBar(
                          unselectedLabelColor: Colors.white,
                          indicatorColor: Colors.black,
                          tabs: [
                            Tab(
                                icon: Text("그룹",
                                    style: TextStyle(color: Colors.black))),
                            Tab(
                                icon: Text("QnA",
                                    style: TextStyle(color: Colors.black))),
                          ],
                        ))
                  ];
                },
                body: TabBarView(
                  children: [
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_transit),
                  ],
                ),
              ),
            );
            // return SingleChildScrollView(
            //     child: Column(
            //   children: [
            //     Container(
            //         padding: EdgeInsets.only(top: 20, bottom: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //         ),
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: 15,
            //             ),
            //             Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                     padding: EdgeInsets.only(
            //                         left: MediaQuery.of(context).size.width *
            //                             0.1)),
            //                 snapshot.data!["url"] == null
            //                     ? Expanded(
            //                         flex: 3,
            //                         child: Container(
            //                           alignment: Alignment.topLeft,
            //                           width: MediaQuery.of(context).size.width *
            //                               0.25,
            //                           child: CircleAvatar(
            //                               radius: 45,
            //                               backgroundColor: Colors.grey[400],
            //                               child: Icon(Icons.person, size: 50)),
            //                         ),
            //                       )
            //                     : Expanded(
            //                         flex: 3,
            //                         child: Container(
            //                           child: CircleAvatar(
            //                             radius: 45,
            //                             backgroundColor: Colors.white,
            //                             backgroundImage: NetworkImage(
            //                                 snapshot.data!["url"] ?? ""),
            //                           ),
            //                         ),
            //                       ),
            //                 Padding(
            //                     padding: EdgeInsets.only(
            //                         left: MediaQuery.of(context).size.width *
            //                             0.06)),
            //                 Expanded(
            //                   flex: 8,
            //                   child: Container(
            //                     alignment: Alignment.topLeft,
            //                     height: 135,
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Expanded(
            //                           flex: 1,
            //                           child: Container(
            //                             child: Text(
            //                                 snapshot.data!['nickname'] ??
            //                                     "User",
            //                                 overflow: TextOverflow.ellipsis,
            //                                 maxLines: 1,
            //                                 style: TextStyle(fontSize: 33)),
            //                           ),
            //                         ),
            //                         Expanded(
            //                           flex: 1,
            //                           child: Container(
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(5),
            //                               child: Text(
            //                                   snapshot.data!['category']
            //                                       .toString(),
            //                                   overflow: TextOverflow.ellipsis,
            //                                   maxLines: 1,
            //                                   style: TextStyle(fontSize: 15)),
            //                             ),
            //                           ),
            //                         ),
            //                         Expanded(
            //                           flex: 1,
            //                           child: Container(
            //                             height: 50,
            //                             margin: EdgeInsets.only(right: 5),
            //                             width:
            //                                 MediaQuery.of(context).size.width *
            //                                     0.7,
            //                             child: FutureBuilder(
            //                                 future: FirebaseFirestore.instance
            //                                     .collection("category")
            //                                     .where("categoryId", whereIn: [
            //                                   // for (int i = 0;
            //                                   //     i <
            //                                   //         category
            //                                   //             .length;
            //                                   //     i++)
            //                                   //   category[i]
            //                                   1,
            //                                   2,
            //                                   3,
            //                                   // 4,
            //                                   // 5,
            //                                 ]).get(),
            //                                 builder: (context,
            //                                     AsyncSnapshot<QuerySnapshot>
            //                                         categoryData) {
            //                                   if (categoryData.hasData) {
            //                                     return GridView.builder(
            //                                         gridDelegate:
            //                                             new SliverGridDelegateWithFixedCrossAxisCount(
            //                                                 crossAxisCount: 3,

            //                                                 // childAspectRatio: MediaQuery.of(
            //                                                 //             context)
            //                                                 //         .size
            //                                                 //         .width /
            //                                                 //     (MediaQuery.of(
            //                                                 //                 context)
            //                                                 //             .size
            //                                                 //             .height /
            //                                                 //         3),
            //                                                 childAspectRatio:
            //                                                     180 / 100),
            //                                         itemCount:
            //                                             categoryData.data!.size,
            //                                         itemBuilder:
            //                                             (context, count) {
            //                                           return Chip(
            //                                               backgroundColor:
            //                                                   Colors.orange[50],
            //                                               // avatar: CircleAvatar(
            //                                               //     radius:
            //                                               //         100,
            //                                               //     backgroundColor:
            //                                               //         Colors.orange[
            //                                               //             50],
            //                                               //     backgroundImage: NetworkImage(categoryData
            //                                               //             .data!
            //                                               //             .docs[count]
            //                                               //         [
            //                                               //         "categoryImage"])),
            //                                               label: Text(categoryData
            //                                                       .data!
            //                                                       .docs[count][
            //                                                   "categoryName"]));
            //                                         });
            //                                   }
            //                                   return Text("");
            //                                 }),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //             //////////////////////
            //             //////////////////////
            //             ///////user vip////////
            //             /////////category 6////////
            //             //////////////////////
            //             //////////////////////
            //             // Row(
            //             //   crossAxisAlignment:
            //             //       CrossAxisAlignment.start,
            //             //   children: [
            //             //     Padding(
            //             //         padding: EdgeInsets.only(
            //             //             left: MediaQuery.of(context)
            //             //                     .size
            //             //                     .width *
            //             //                 0.01)),
            //             //     snapshot.user.url == null
            //             //         ? Expanded(
            //             //             flex: 3,
            //             //             child: Container(
            //             //               alignment: Alignment.topLeft,
            //             //               width: MediaQuery.of(context)
            //             //                       .size
            //             //                       .width *
            //             //                   0.25,
            //             //               child: CircleAvatar(
            //             //                   radius: 45,
            //             //                   backgroundColor:
            //             //                       Colors.grey[400],
            //             //                   child: Icon(Icons.person,
            //             //                       size: 50)),
            //             //             ),
            //             //           )
            //             //         : Expanded(
            //             //             flex: 3,
            //             //             child: Container(
            //             //               child: CircleAvatar(
            //             //                 radius: 45,
            //             //                 backgroundColor: Colors.white,
            //             //                 backgroundImage: NetworkImage(
            //             //                     snapshot.user.url ?? ""),
            //             //               ),
            //             //             ),
            //             //           ),
            //             //     Padding(
            //             //         padding: EdgeInsets.only(
            //             //             left: MediaQuery.of(context)
            //             //                     .size
            //             //                     .width *
            //             //                 0.03)),
            //             //     Expanded(
            //             //       flex: 8,
            //             //       child: Container(
            //             //         alignment: Alignment.topLeft,
            //             //         height: 165,
            //             //         child: Column(
            //             //           crossAxisAlignment:
            //             //               CrossAxisAlignment.start,
            //             //           children: [
            //             //             Container(
            //             //               child: Text(
            //             //                   snapshot.user.nickname ??
            //             //                       "User",
            //             //                   overflow:
            //             //                       TextOverflow.ellipsis,
            //             //                   maxLines: 1,
            //             //                   style: TextStyle(
            //             //                       fontSize: 33)),
            //             //             ),
            //             //             Container(
            //             //               child: Padding(
            //             //                 padding:
            //             //                     const EdgeInsets.all(5),
            //             //                 child: Text(
            //             //                     snapshot.user.category
            //             //                         .toString(),
            //             //                     overflow:
            //             //                         TextOverflow.ellipsis,
            //             //                     maxLines: 1,
            //             //                     style: TextStyle(
            //             //                         fontSize: 15)),
            //             //               ),
            //             //             ),
            //             //             Container(
            //             //               height: 90,
            //             //               width: MediaQuery.of(context)
            //             //                       .size
            //             //                       .width *
            //             //                   0.7,
            //             //               child: FutureBuilder(
            //             //                   future: FirebaseFirestore
            //             //                       .instance
            //             //                       .collection("category")
            //             //                       .where("categoryId",
            //             //                           whereIn: [
            //             //                         // for (int i = 0;
            //             //                         //     i <
            //             //                         //         category
            //             //                         //             .length;
            //             //                         //     i++)
            //             //                         //   category[i]
            //             //                         1,
            //             //                         2,
            //             //                         3,
            //             //                         4,
            //             //                         5,
            //             //                       ]).get(),
            //             //                   builder: (context,
            //             //                       AsyncSnapshot<
            //             //                               QuerySnapshot>
            //             //                           categoryData) {
            //             //                     if (categoryData
            //             //                         .hasData) {
            //             //                       print(categoryData
            //             //                               .data!.docs[0]
            //             //                           ['categoryName']);

            //             //                       return GridView.builder(
            //             //                           gridDelegate:
            //             //                               new SliverGridDelegateWithFixedCrossAxisCount(
            //             //                                   crossAxisCount:
            //             //                                       3,

            //             //                                   // childAspectRatio: MediaQuery.of(
            //             //                                   //             context)
            //             //                                   //         .size
            //             //                                   //         .width /
            //             //                                   //     (MediaQuery.of(
            //             //                                   //                 context)
            //             //                                   //             .size
            //             //                                   //             .height /
            //             //                                   //         3),
            //             //                                   childAspectRatio:
            //             //                                       180 /
            //             //                                           100),
            //             //                           itemCount:
            //             //                               categoryData
            //             //                                   .data!.size,
            //             //                           itemBuilder:
            //             //                               (context,
            //             //                                   count) {
            //             //                             return Chip(
            //             //                                 backgroundColor:
            //             //                                     Colors.orange[
            //             //                                         50],
            //             //                                 // avatar: CircleAvatar(
            //             //                                 //     radius:
            //             //                                 //         100,
            //             //                                 //     backgroundColor:
            //             //                                 //         Colors.orange[
            //             //                                 //             50],
            //             //                                 //     backgroundImage: NetworkImage(categoryData
            //             //                                 //             .data!
            //             //                                 //             .docs[count]
            //             //                                 //         [
            //             //                                 //         "categoryImage"])),
            //             //                                 label: Text(categoryData
            //             //                                         .data!
            //             //                                         .docs[count]
            //             //                                     [
            //             //                                     "categoryName"]));
            //             //                           });
            //             //                     }
            //             //                     return Text("??");
            //             //                   }),
            //             //             )
            //             //           ],
            //             //         ),
            //             //       ),
            //             //     )
            //             //   ],
            //             // ),
            //             // Padding(padding: EdgeInsets.only(top: 8)),
            //             Card(
            //               elevation: 3,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(15),
            //                 side: BorderSide(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Column(
            //                 children: [
            //                   Container(
            //                     padding: EdgeInsets.all(10),
            //                     height: 100,
            //                     width: MediaQuery.of(context).size.width * 0.85,
            //                     child: Text(
            //                         snapshot.data!["introduction"] ?? "",

            //                         // "write yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourselfwrite yourself",
            //                         maxLines: 5,
            //                         overflow: TextOverflow.ellipsis,
            //                         textAlign: TextAlign.start,
            //                         style:
            //                             //userModel.introduction == null

            //                             //  ?
            //                             TextStyle(
            //                                 color: Colors.black, fontSize: 12)
            //                         // : MyText.subhead(context)!
            //                         //     .copyWith(
            //                         //         color: Colors.grey[900])
            //                         ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         )),
            //     Column(
            //       children: [
            //         Container(
            //           height: 80,
            //           child: DefaultTabController(
            //             length: 3,
            //             child: TabBar(
            //               controller: _controller,
            //               tabs: [
            //                 Tab(icon: Text("프로필")),
            //                 Tab(icon: Text("그룹")),
            //                 Tab(icon: Text("QnA")),
            //               ],
            //             ),
            //           ),
            //         ),
            //         TabBarView(
            //           controller: _controller,
            //           children: [
            //             Icon(Icons.directions_transit),
            //             ListView(shrinkWrap: true, children: [

            //             ]),
            //             Icon(Icons.directions_bike),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ));
          }),
    );
  }
}
