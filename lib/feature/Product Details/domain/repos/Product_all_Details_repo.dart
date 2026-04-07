import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entites/product_entity.dart';

abstract class ProductDetailsRepo {
  // 1. جلب تفاصيل منتج معين بشكل كامل
  Future<Either<Failure, ProductEntity>> getProductDetails({required String productId});

  // 2. جلب التقييمات (Reviews) الخاصة بهذا المنتج
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductReviews({required String productId});
}