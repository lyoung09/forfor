import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/bottomScreen/infomation/model/posting_model.dart';
import 'package:get/state_manager.dart';

class PostingController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxList<PostingModel> postings = RxList<PostingModel>([]);

  late CollectionReference collectionReference;
  late CollectionReference clickCollectionReference;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("posting");

    postings.bindStream(getAllCategogy());
  }

  Stream<List<PostingModel>> getAllCategogy() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => PostingModel.fromMap(item)).toList());
}
