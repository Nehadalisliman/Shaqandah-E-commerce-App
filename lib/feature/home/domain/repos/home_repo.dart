import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/CategoryEntity.dart';
import '../entites/brand_type_entity.dart';
import '../entites/product_entity.dart'; // مهم جداً عشان الـ Either

abstract class HomeRepo {
  // 1. جلب قائمة المنتجات مع إمكانية الفلترة اختيارياً
  // لو بعتنا IDs هيفلتر، لو مبعتناش (null) هيجيب كل المنتجات
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    String? brandTypeId,
  });

  // 2. جلب قائمة التصنيفات (Categories)
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  // 3. جلب أنواع البراندات (Outlet Brands & Local Brands)
  Future<Either<Failure, List<BrandTypeEntity>>> getBrandTypes();
}