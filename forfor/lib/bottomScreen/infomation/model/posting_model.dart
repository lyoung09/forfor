import 'package:cloud_firestore/cloud_firestore.dart';

import 'posting_otherClick.dart';

class PostingModel {
  String? postingId;
  int? replyCount;
  String? authorId;
  int? category;
  List? images;
  List? save;
  String? story;
  Timestamp? timestamp;
  //List<OtherUserClick>? click;
  PostingModel({
    this.postingId,
    this.replyCount,
    this.authorId,
    this.category,
    this.images,
    this.save,
    this.story,
    this.timestamp,
    // this.click,
  });

  factory PostingModel.fromMap(dynamic fieldData) {
    return PostingModel(
      postingId: fieldData["postingId"],
      replyCount: fieldData['replyCount'],
      authorId: fieldData['authorId'],
      category: fieldData['category'],
      images: fieldData['images'] == null || fieldData['images'] == ""
          ? null
          : fieldData['images'],
      save: fieldData['save'] == null || fieldData['save'] == ""
          ? null
          : fieldData['save'],
      story: fieldData['story'] == null ? null : fieldData['story'],
      timestamp: fieldData['timestamp'] == null ? null : fieldData['timestamp'],
    );
  }
}
