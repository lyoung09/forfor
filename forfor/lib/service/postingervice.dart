import 'package:cloud_firestore/cloud_firestore.dart';

class PostingService {
  CollectionReference _postingref =
      FirebaseFirestore.instance.collection('posting');

  noCategory() {
    return _postingref.orderBy("timestamp", descending: true).snapshots();
  }

  selectCategory(checkCategory) {
    return _postingref
        .where("category", isEqualTo: checkCategory)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  posting(checkCategory) {
    return _postingref
        .where("category", isEqualTo: checkCategory)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  favorite(postingId) {
    return _postingref.doc(postingId).collection('likes').snapshots();
  }

  //_categoryref.orderBy("categoryId").snapshots()
}
