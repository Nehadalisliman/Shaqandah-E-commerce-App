import '../../domain/entites/product_entity.dart';
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.productId,
    required super.productName,
    required super.brandName,
    required super.category,
    required super.categoryId,
    required super.brandTypeId,
    required super.description,
    required super.mainImage,
    required super.otherImages,
    required super.price,
    required super.oldPrice,
    required super.colors,
    required super.sizes,
    required super.material,
    required super.videoUrl,
  });

  // تعديل الـ factory لاستقبال الـ Data والـ ID بشكل صحيح
  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      productId: documentId,
      productName: json['ProductName'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      category: json['category'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      brandTypeId: json['brandTypeId'] as String? ?? '',
      description: json['description'] as String? ?? '',
      mainImage: json['mainImage'] as String? ?? '',

      // معالجة الـ Lists لضمان عدم حدوث Crash لو القيمة null
      otherImages: json['otherImages'] is List
          ? List<String>.from(json['otherImages'])
          : [],

      price: json['price'] as num? ?? 0,
      oldPrice: json['oldPrice'] as num? ?? 0,

      colors: json['colors'] is List
          ? List<String>.from(json['colors'])
          : [],

      sizes: json['sizes'] is List
          ? List<String>.from(json['sizes'])
          : [],

      material: json['material'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductName': productName,
      'brandName': brandName,
      'category': category,
      'categoryId': categoryId,
      'brandTypeId': brandTypeId,
      'description': description,
      'mainImage': mainImage,
      'otherImages': otherImages,
      'price': price,
      'oldPrice': oldPrice,
      'colors': colors,
      'sizes': sizes,
      'material': material,
      'videoUrl': videoUrl,
      // الـ productId غالباً مش بنرفعه لأنه بيكون اسم الـ Document نفسه
    };
  }
}