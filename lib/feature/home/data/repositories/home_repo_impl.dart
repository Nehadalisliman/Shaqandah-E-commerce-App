import 'package:dartz/dartz.dart';

import 'package:firebase_core/firebase_core.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entites/CategoryEntity.dart';
import '../../domain/entites/brand_type_entity.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/repos/home_repo.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    String? brandTypeId,
  }) async {
    try {
      // جلب البيانات من الـ DataSource (بترجع List<ProductModel>)
      final products = await homeRemoteDataSource.fetchProducts(
        categoryId: categoryId,
        brandTypeId: brandTypeId,
      );

      // الحل: تحويل النوع بشكل صريح إلى List<ProductEntity>
      return right(products.cast<ProductEntity>());

    } on FirebaseException catch (e) {
      return left(ServerFailure(e.message ?? 'خطأ في الاتصال بقاعدة البيانات'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.fetchCategories();
      // نفس الشيء هنا للتأكيد
      return right(categories.cast<CategoryEntity>());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BrandTypeEntity>>> getBrandTypes() async {
    try {
      final brandTypes = await homeRemoteDataSource.fetchBrandTypes();
      // نفس الشيء هنا للتأكيد
      return right(brandTypes.cast<BrandTypeEntity>());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}