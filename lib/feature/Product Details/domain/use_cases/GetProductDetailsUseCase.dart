import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entites/product_entity.dart';
import '../../data/repositories/Product_Details_repo_impl.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepo repository;

  // بنحقن الـ Repository هنا عشان الـ UseCase يعرف يكلمه
  GetProductDetailsUseCase(this.repository);

  // دالة call بتخلينا نستخدم الـ UseCase كأنها Function في الـ Cubit
  Future<Either<Failure, ProductEntity>> call(String productId) async {
    return await repository.getProductDetails(productId);
  }
}