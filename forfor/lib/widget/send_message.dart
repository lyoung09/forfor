import 'package:flutter/material.dart';
import 'package:forfor/widget/chatting_bubble.dart';

class SentMessageScreen extends StatelessWidget {
  final String message;
  const SentMessageScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.cyan[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        //CustomPaint(painter: CustomShape(Colors.cyan[900])),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
