import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forfor/bottomScreen/infomation/info_controller/posting_controller.dart';

import 'package:forfor/bottomScreen/infomation/info_widget/qna_screen_widget.dart';
import 'package:forfor/bottomScreen/infomation/sayReply.dart';
import 'package:forfor/bottomScreen/infomation/sayWrite.dart';
import 'package:forfor/bottomScreen/otherProfile/otherProfile.dart';
import 'package:forfor/controller/bind/authcontroller.dart';
import 'dart:math' as math;

import 'package:forfor/controller/categoryController.dart';
import 'package:forfor/service/postingervice.dart';
import 'package:forfor/utils/datetime.dart';
import 'package:get/get.dart';

class PostingMainScreen extends StatefulWidget {
  const PostingMainScreen({Key? key}) : super(key: key);

  @override
  _PostingMainScreenState createState() => _PostingMainScreenState();
}

class _PostingMainScreenState extends State<PostingMainScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation, animation1View;
  bool expand = false;
  String category = "all";
  int checkCategory = 0;
  final categoryController = Get.put(CategoryController());
  final postingController = Get.put(PostingController());
  final userController = Get.put(AuthController());
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    animation = Tween(begin: 0.0, end: 180.0).animate(controller);
    animation1View = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.addListener(() {
      setState(() {});
    });
  }

  void togglePanel1() {
    if (!expand) {
      controller.forward();
    } else {
      controller.reverse();
    }
    expand = !expand;
  }

  Widget exapnded() {
    return Row(
      children: [
        Spacer(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, left: 1, right: 1),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 0.9))),
                  child: Text("${category}",
                      style: TextStyle(
                          color: Colors.grey[800], fontFamily: "GloryBold")),
                ),
              ),
              Padding(padding: EdgeInsets.all(2)),
              Transform.rotate(
                angle: animation.value * math.pi / 180,
                child: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: () {
                    togglePanel1();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  writingPage() {
    Get.to(() => SayWriting(uid: userController.user!.uid));
  }

  Widget gridViewCategory() {
    return SizeTransition(
      sizeFactor: animation1View,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        //padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Obx(
          () => GridView.builder(
              padding: EdgeInsets.only(top: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2, mainAxisSpacing: 2, crossAxisCount: 4),
              itemCount: categoryController.categorys.length,
              itemBuilder: (BuildContext context, count) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      checkCategory =
                          categoryController.categorys[count].categoryId!;
                      category =
                          categoryController.categorys[count].categoryName!;
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.network(
                          categoryController.categorys[count].categoryImage!,
                          width: 30,
                          scale: 1,
                        ),
                      ),
                      Text(
                        categoryController.categorys[count].categoryName!,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: checkCategory == 0
                ? PostingService().noCategory()
                : PostingService().selectCategory(checkCategory),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading"));
              }
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("QnA",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                          ),
                          iconSize: 25,
                          //onPressed: alarmPage,
                          onPressed: () {},
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            iconSize: 25,
                            onPressed: writingPage),
                      ]),
                      Container(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey[800],
                      )),
                      exapnded(),
                      expand == true
                          ? Container(child: gridViewCategory(), height: 200)
                          : Container(
                              height: 0,
                            ),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: postingController.postings.length,
                          itemBuilder: (context, index) {
                            Map<int, String> ago = new Map<int, String>();
                            ago[index] = DatetimeFunction().ago(
                                postingController.postings[index].timestamp!);

                            return QnaScreenWidget(
                              postingController: postingController,
                              ago: ago[index]!,
                              index: index,
                              userId: userController.user!.uid,
                            );
                          },
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
