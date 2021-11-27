import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forfor/model/category.dart';
import 'package:get/state_manager.dart';

class CategoryController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxList<CategoryModel> categorys = RxList<CategoryModel>([]);

  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("category");
    categorys.bindStream(getAllCategogy());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<CategoryModel>> getAllCategogy() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => CategoryModel.fromMap(item)).toList());
}
