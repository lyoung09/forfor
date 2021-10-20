import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/infomation/sayWrite.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyQuestion extends StatefulWidget {
  final String myId;
  final String myName;
  final String myCountry;
  final String myImage;

  const MyQuestion(
      {Key? key,
      required this.myId,
      required this.myName,
      required this.myCountry,
      required this.myImage})
      : super(key: key);

  @override
  _MyQuestionState createState() => _MyQuestionState();
}

class _MyQuestionState extends State<MyQuestion> {
  String _ago(Timestamp t) {
    String x = timeago
        .format(t.toDate())
        .replaceAll("minutes", "분")
        .replaceAll("a minute", "1분")
        .replaceAll("a moment", "방금")
        .replaceAll("a day", "1일")
        .replaceAll("ago", "전")
        .replaceAll("about", "")
        .replaceAll("an hour", "한시간")
        .replaceAll("hours", "시간")
        .replaceAll("one year", "1년")
        .replaceAll("years", "년");

    return x;
  }

  writingPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SayWriting(
            uid: widget.myId,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Question",
              style: TextStyle(color: Colors.black, fontSize: 32)),
          centerTitle: true,
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.edit),
                iconSize: 32,
                onPressed: writingPage),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("posting")
              .where("authorId", isEqualTo: widget.myId)
              //.orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> posting) {
            if (!posting.hasData) {
              return Container();
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: posting.data!.size,
                itemBuilder: (context, index) {
                  Map<int, String> ago = new Map<int, String>();
                  ago[index] = _ago(posting.data!.docs[index]["timestamp"]);
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                        ),
                        Expanded(
                          child: Bubble(
                            showNip: true,
                            padding: BubbleEdges.only(
                                left: 22, top: 10, bottom: 0, right: 22),
                            alignment: Alignment.centerLeft,
                            borderColor: Colors.black,
                            borderWidth: 1.3,
                            nip: BubbleNip.rightCenter,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('${widget.myName}',
                                              //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.orange[400],
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 5)),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${posting.data!.docs[index]["story"]}',
                                      //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                Divider(
                                  thickness: 0.7,
                                  color: Colors.grey[200],
                                ),
                                Container(
                                  height: 30,
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${ago[index]}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      Text(
                                          " ${posting.data!.docs[index]["address"]}",
                                          style: TextStyle(fontSize: 13)),
                                      Spacer(),
                                      IconButton(
                                        iconSize: 17.5,
                                        icon: Icon(
                                            Icons.chat_bubble_outline_outlined),
                                        onPressed: () {
                                          Get.to(() => SayReply(
                                                postingId: posting
                                                    .data!.docs[index].id,
                                                userId: widget.myId,
                                                authorId: posting.data!
                                                    .docs[index]["authorId"],
                                                time: ago[index]!,
                                                replyCount: posting.data!
                                                    .docs[index]["replyCount"],
                                                story: posting.data!.docs[index]
                                                    ["story"],
                                              ));
                                        },
                                      ),
                                      Text(
                                        posting.data!.docs[index]
                                                        ["replyCount"] ==
                                                    null ||
                                                posting.data!.docs[index]
                                                        ["replyCount"] <
                                                    1
                                            ? ""
                                            : "${posting.data!.docs[index]["replyCount"]} ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Container(
                                          width: 65,
                                          height: 65,
                                          child: Image.network(
                                            '${widget.myImage}',
                                            fit: BoxFit.fitWidth,
                                          )),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: -4,
                                  //   left: 0,
                                  //   child: CircleAvatar(
                                  //     backgroundImage: AssetImage(
                                  //         'icons/flags/png/${widget.myCountry}.png',
                                  //         package: 'country_icons'),
                                  //     backgroundColor: Colors.white,
                                  //     radius: 15,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
