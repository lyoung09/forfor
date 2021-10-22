import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.orange[50]));
  }
}

class PicLimit extends StatefulWidget {
  const PicLimit({Key? key}) : super(key: key);

  @override
  _PicLimitState createState() => _PicLimitState();
}

class _PicLimitState extends State<PicLimit> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Colors.white,
      width: 150,
      height: 80,
      child: Column(
        children: [
          Text("최대 6장 입니다."),
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("확인")),
        ],
      ),
    ));
  }
}
