
import '../../domain/entites/brand_type_entity.dart';

class BrandTypeModel extends BrandTypeEntity {
  const BrandTypeModel({
    required super.id,
    required super.typeName, // تعديل الاسم ليطابق الـ Entity
    required super.typeImage
    , // تعديل الاسم ليطابق الـ Entity
  });

  factory BrandTypeModel.fromJson(Map<String, dynamic> json) {
    return BrandTypeModel(
      // تأكدي أن الـ keys هنا تطابق بالظبط اللي كتبناه في Firestore
      id: json['id'] ?? '',
      typeName: json['typeName'] ?? '',
      typeImage: json['typeImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeName': typeName,
      'typeImage': typeImage,
    };
  }
}