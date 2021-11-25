import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  int? categoryId;
  String? categoryImage;
  String? categoryName;

  CategoryModel({
    this.categoryId,
    this.categoryImage,
    this.categoryName,
  });

  factory CategoryModel.fromMap(dynamic fieldData) {
    return CategoryModel(
      categoryId: fieldData['categoryId'],
      categoryImage: fieldData['categoryImage'],
      categoryName: fieldData['categoryName'],
    );
  }
}
