
import '../../domain/entites/BrandEntity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.brandId,
    required super.brandName,
    required super.brandImage,
  });

  // تحويل البيانات القادمة من Firestore Map إلى Model
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      brandImage: json['brandImage'] ?? '',
    );
  }

  // تحويل الـ Model إلى Map (في حال أردتِ إضافة براند جديد من لوحة التحكم مستقبلاً)
  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'brandName': brandName,
      'brandImage': brandImage,
    };
  }
}