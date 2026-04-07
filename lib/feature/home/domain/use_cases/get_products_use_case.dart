import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/product_entity.dart';
import '../repos/home_repo.dart';


class GetProductsUseCase {
  final HomeRepo homeRepo;

  GetProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductEntity>>> call({
    String? categoryId,
    String? brandTypeId,
  }) async {
    return await homeRepo.getProducts(
      categoryId: categoryId,
      brandTypeId: brandTypeId,
    );
  }
}