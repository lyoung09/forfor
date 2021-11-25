import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/info_controller/posting_controller.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:get/get.dart';

import '../sayReply.dart';

class QnaScreenWidget extends StatelessWidget {
  final PostingController postingController;
  final String ago;
  final int index;
  final String userId;
  const QnaScreenWidget({
    Key? key,
    required this.postingController,
    required this.ago,
    required this.index,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage("${snapshot.data!["url"]}")),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'icons/flags/png/${snapshot.data!["country"]}.png',
                        package: 'country_icons'),
                    backgroundColor: Colors.white,
                    radius: 8,
                  ),
                ),
              ],
            );
          }),
      title: Text("name"),
      subtitle: Text(
        '${postingController.postings[index].story}',
        //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14),
      ),
      trailing: Text(ago),
    );

    // child: Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 2.0),
    //           child: GestureDetector(
    //             onTap: () {
    //               Get.to(() => OtherProfile(
    //                     uid: postingController.postings[index].authorId!,
    //                   ));
    //             },
    //             child:
    // StreamBuilder(
    //                 stream: FirebaseFirestore.instance
    //                     .collection('users')
    //                     .doc(userId)
    //                     .snapshots(),
    //                 builder:
    //                     (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //                   if (!snapshot.hasData) {
    //                     return Container();
    //                   }
    //                   return Stack(
    //                     children: [
    //                       Padding(
    //                         padding: EdgeInsets.only(left: 5.0),
    //                         child: CircleAvatar(
    //                             radius: 25,
    //                             backgroundColor: Colors.white,
    //                             backgroundImage:
    //                                 NetworkImage("${snapshot.data!["url"]}")),
    //                       ),
    //                       Positioned(
    //                         bottom: 0,
    //                         right: 0,
    //                         child: CircleAvatar(
    //                           backgroundImage: AssetImage(
    //                               'icons/flags/png/${snapshot.data!["country"]}.png',
    //                               package: 'country_icons'),
    //                           backgroundColor: Colors.white,
    //                           radius: 8,
    //                         ),
    //                       ),
    //                     ],
    //                   );
    //                 }),
    //           ),
    //         ),
    //         Expanded(
    //           flex: 8,
    //           child: Padding(
    //             padding:
    //                 const EdgeInsets.only(bottom: 10.0, left: 5, right: 5),
    //             child: Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                     "ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhla",
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: TextStyle(
    //                         fontSize: 18.5,
    //                         color: Colors.orange[400],
    //                         fontWeight: FontWeight.bold))),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(bottom: 10.0),
    //           child: Text(
    //             ago,
    //             style: TextStyle(fontSize: 12),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
    //       child: Align(
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             '${postingController.postings[index].story}',
    //             //"ehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkhehlehlhelrhlahrlkh",
    //             maxLines: 4,
    //             overflow: TextOverflow.ellipsis,
    //             style: TextStyle(fontSize: 14),
    //           )),
    //     ),
    //     postingController.postings[index].images == null
    //         ? Text("")
    //         : postingController.postings[index].images!.length <= 3
    //             ? Container(
    //                 height: 120,
    //                 child: GridView.builder(
    //                     shrinkWrap: false,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     gridDelegate:
    //                         SliverGridDelegateWithFixedCrossAxisCount(
    //                             crossAxisCount: 3),
    //                     itemCount:
    //                         postingController.postings[index].images!.length,
    //                     itemBuilder: (BuildContext context, count) {
    //                       return Center(
    //                         child: Image.network(
    //                             postingController
    //                                 .postings[index].images![count],
    //                             width: 100,
    //                             height: 100,
    //                             fit: BoxFit.cover),
    //                       );
    //                     }),
    //               )
    //             : Container(
    //                 height: 250,
    //                 child: GridView.builder(
    //                     shrinkWrap: false,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     gridDelegate:
    //                         SliverGridDelegateWithFixedCrossAxisCount(
    //                             crossAxisCount: 3),
    //                     itemCount:
    //                         postingController.postings[index].images!.length,
    //                     itemBuilder: (BuildContext context, count) {
    //                       return Center(
    //                         child: Image.network(
    //                             postingController
    //                                 .postings[index].images![count],
    //                             width: 100,
    //                             height: 100,
    //                             fit: BoxFit.cover),
    //                       );
    //                     }),
    //               ),
    //     SizedBox(height: 10),
    //     Container(
    //       height: 30,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           SizedBox(width: 15),
    //           // StreamBuilder<DocumentSnapshot>(
    //           //     stream: _postingref
    //           //         .doc( postingController.postings[index].postingId)
    //           //         .collection('likes')
    //           //         .doc(userController.user!.uid)
    //           //         .snapshots(),
    //           //     builder: (context,
    //           //         AsyncSnapshot<DocumentSnapshot> likeUser) {
    //           //       if (!likeUser.hasData) {
    //           //         favorite[index] = false;
    //           //       }
    //           //       if (likeUser.hasData) {
    //           //         favorite[index] = likeUser.data!.exists;
    //           //       }
    //           //       return IconButton(
    //           //         onPressed: () {
    //           //           favorite[index] = !favorite[index];
    //           //           check(posting, index, favorite, token);
    //           //         },
    //           //         icon: Icon(
    //           //           Icons.favorite,
    //           //           color: favorite[index] == true
    //           //               ? Colors.red[400]
    //           //               : Colors.grey[300],
    //           //         ),
    //           //       );
    //           //     }),
    //           // SizedBox(width: 15),
    //           // StreamBuilder(
    //           //     stream: _postingref
    //           //         .doc( postingController.postings[index].postingId)
    //           //         .collection('likes')
    //           //         .snapshots(),
    //           //     builder: (context,
    //           //         AsyncSnapshot<QuerySnapshot> snapshot) {
    //           //       if (!snapshot.hasData) {
    //           //         return Container(
    //           //           height: 0,
    //           //           width: 0,
    //           //         );
    //           //       }
    //           //       return Padding(
    //           //         padding: const EdgeInsets.only(right: 8.0),
    //           //         child: Text(
    //           //           snapshot.data!.docs.length < 1
    //           //               ? ""
    //           //               : "${snapshot.data!.docs.length.toString()} ",
    //           //           style: TextStyle(fontSize: 12),
    //           //         ),
    //           //       );
    //           //     }),
    //           IconButton(
    //             iconSize: 17.5,
    //             icon: Icon(Icons.chat_bubble_outline_outlined),
    //             onPressed: () {
    //               Get.to(() => SayReply(
    //                     postingId:
    //                         postingController.postings[index].postingId!,
    //                     userId: userId,
    //                     authorId: postingController.postings[index].authorId!,
    //                     //time: ago[index]!,

    //                     replyCount:
    //                         postingController.postings[index].replyCount!,
    //                     story: postingController.postings[index].story!,
    //                     time: '',
    //                   ));
    //             },
    //           ),
    //           Text(
    //             postingController.postings[index].replyCount == null ||
    //                     postingController.postings[index].replyCount! < 1
    //                 ? ""
    //                 : "${postingController.postings[index].replyCount.toString()} ",
    //             style: TextStyle(fontSize: 12),
    //           ),
    //           Spacer(),
    //           Align(
    //             alignment: Alignment.topRight,
    //             child: IconButton(
    //               icon: Icon(Icons.more_vert, size: 17),
    //               onPressed: () {
    //                 // postingExtra(
    //                 //   context,
    //                 //    postingController.postings[index].postingId,
    //                 //    postingController.postings[index].authorId,
    //                 //    postingController.postings[index].save,
    //                 // );
    //               },
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     SizedBox(width: 7.5),
    //   ],
    // ),
    // );
  }
}
