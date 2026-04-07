import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String productName;
  final String brandName;
  final String category;      // اسم الكاتجوري (للعرض في الواجهة)
  final String categoryId;    // المعرف الخاص بالكاتجوري (للفلترة في Firebase)
  final String brandTypeId;   // المعرف الخاص بنوع البراند (للفلترة المتقدمة)
  final String description;
  final String mainImage;
  final List<String> otherImages;
  final num price;
  final num oldPrice;
  final List<String> colors;
  final List<String> sizes;
  final String material;
  final String videoUrl;

  const ProductEntity({
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.category,
    required this.categoryId,
    required this.brandTypeId,
    required this.description,
    required this.mainImage,
    required this.otherImages,
    required this.price,
    required this.oldPrice,
    required this.colors,
    required this.sizes,
    required this.material,
    required this.videoUrl,
  });

  @override
  List<Object?> get props => [
    productId,
    productName,
    brandName,
    category,
    categoryId,
    brandTypeId,
    description,
    mainImage,
    otherImages,
    price,
    oldPrice,
    colors,
    sizes,
    material,
    videoUrl,
  ];
}