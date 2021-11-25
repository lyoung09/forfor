import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/bottomScreen/infomation/model/posting_model.dart';

class PostingDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getPosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").get();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getDetailPosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> favoritePosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> replyPosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addPosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> savePosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> suePosting(PostingModel postingModel) async {
    try {
      await _firestore.collection("posting").add({});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
