import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entites/product_entity.dart';
import '../datasources/Product_Details_remote_data_source.dart';

abstract class ProductDetailsRepo {
  Future<Either<Failure, ProductEntity>> getProductDetails(String productId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductReviews(String productId);
}
class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDataSource productDetailsRemoteDataSource;

  ProductDetailsRepoImpl({required this.productDetailsRemoteDataSource});

  Future<Either<Failure, ProductEntity>> getProductDetails(String productId) async {
    try {
      // 1. طلب البيانات من الـ Remote Data Source
      final productModel = await productDetailsRemoteDataSource.getProductDetails(productId);

      // 2. إرجاع النتيجة بنجاح (Right)
      return right(productModel as ProductEntity);
    } on FirebaseException catch (e) {
      // 3. معالجة أخطاء الفايربيز (Left)
      return left(ServerFailure(e.message ?? 'خطأ في جلب بيانات المنتج من الفايربيز'));
    } catch (e) {
      // 4. معالجة أي خطأ غير متوقع
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductReviews(String productId) async {
    try {
      final reviews = await productDetailsRemoteDataSource.getProductReviews(productId);
      return right(reviews);
    } catch (e) {
      return left(ServerFailure("تعذر تحميل التقييمات: ${e.toString()}"));
    }
  }
}