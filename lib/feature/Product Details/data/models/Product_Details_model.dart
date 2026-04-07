
import '../../../home/domain/entites/product_entity.dart';

class ProductDetailsModel extends ProductEntity {
  const ProductDetailsModel({
    required super.productId,
    required super.productName,
    required super.brandName,
    required super.description,
    required super.mainImage,
    required super.price,
    required super.colors,
    required super.sizes,
    required super.category,
    required super.categoryId,
    required super.brandTypeId,
    required super.oldPrice,
    required super.material,
    required super.otherImages,
    required super.videoUrl,
  });

  // الفاكتوري ده هو المسؤول عن تحويل الـ Map اللي جاية من Firestore لموديل بيفهمه فلاتر
  factory ProductDetailsModel.fromFirestore(Map<String, dynamic> json, String docId) {
    return ProductDetailsModel(
      productId: docId, // الـ ID بتاع الوثيقة في Firestore
      productName: json['ProductName'] ?? '',
      brandName: json['brandName'] ?? '',
      description: json['description'] ?? '',
      mainImage: json['mainImage'] ?? '',
      price: json['price'] ?? 0,
      oldPrice: json['oldPrice'] ?? 0,
      category: json['category'] ?? '',
      categoryId: json['categoryId'] ?? '',
      brandTypeId: json['brandTypeId'] ?? '',
      material: json['material'] ?? '',
      videoUrl: json['videoUrl'] ?? '',

      // معالجة القوائم (Arrays) عشان نضمن إنها متبقاش null وتعمل Crash
      colors: json['colors'] is List ? List<String>.from(json['colors']) : [],
      sizes: json['sizes'] is List ? List<String>.from(json['sizes']) : [],
      otherImages: json['otherImages'] is List ? List<String>.from(json['otherImages']) : [],
    );
  }

  // لو حبينا نرفع بيانات أو نبعت داتا تانية (اختياري)
  Map<String, dynamic> toMap() {
    return {
      'ProductName': productName,
      'brandName': brandName,
      'description': description,
      'mainImage': mainImage,
      'price': price,
      'colors': colors,
      'sizes': sizes,
      // ... باقي الحقول
    };
  }
}