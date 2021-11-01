import 'package:flutter/material.dart';
import 'package:forfor/model/message.dart';

class ReplyMessageWidget extends StatelessWidget {
  final String message;
  final String messageName;
  final VoidCallback onCancelReply;

  const ReplyMessageWidget(
      {required this.message,
      required this.messageName,
      required this.onCancelReply,
      key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: Colors.green,
              width: 4,
            ),
            const SizedBox(width: 8),
            Expanded(child: buildReplyMessage()),
          ],
        ),
      );

  Widget buildReplyMessage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${messageName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (onCancelReply != null)
                GestureDetector(
                  child: Icon(Icons.close, size: 16),
                  onTap: onCancelReply,
                )
            ],
          ),
          const SizedBox(height: 8),
          Text(message, style: TextStyle(color: Colors.black54)),
        ],
      );
}
