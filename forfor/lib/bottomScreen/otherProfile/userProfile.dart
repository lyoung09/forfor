import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

//1.친구  ==> 다 볼수있게 --> 사진 밑에 소개 밑에 카테고리, 모든 그룹 포스팅 , QnA // 초대하기 버튼(내가 그룹있다면),메세지버튼
//2.그룹친구 ==>  사진 밑에 소개 밑에 카테고리 및 그룹 포스팅 및 QnA// 초대하기 버튼(내가 그룹있다면),메세지버튼(거절 되 ㅇㅆ으면 안되겟징)
//3.남 ==> 다 볼수있게 --> 사진 밑에 소개 밑에 카테고리 QnA// 초대하기 버튼(내가 그룹있다면),메세지버튼
class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    );
  }
}
