import 'package:cloud_firestore/cloud_firestore.dart';

class OtherUserClick {
  String? authorId;
  String? clickId;
  String? postingId;
  String? reply;
  Timestamp? dateTime;
  String? style;
  OtherUserClick({
    this.authorId,
    this.clickId,
    this.postingId,
    this.reply,
    this.dateTime,
    this.style,
  });

  factory OtherUserClick.fromMap(dynamic fieldData) {
    return OtherUserClick(
      postingId: fieldData["postingId"],
      authorId: fieldData['authorId'],
      clickId: fieldData['clickId'],
      reply: fieldData['reply'],
      dateTime: fieldData['dateTime'],
      style: fieldData['style'],
    );
  }
}
