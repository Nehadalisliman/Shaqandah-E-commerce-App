

import '../../domain/entites/CategoryEntity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.categoryId,
    required super.categoryName,
    required super.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] ?? '',
      categoryName: json['CategoryName'] ?? '',
      categoryImage: json['categoryImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
    };
  }
}