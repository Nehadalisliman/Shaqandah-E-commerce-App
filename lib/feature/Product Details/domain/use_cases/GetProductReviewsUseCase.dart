import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repositories/Product_Details_repo_impl.dart';

class GetProductReviewsUseCase {
  final ProductDetailsRepo repository;

  GetProductReviewsUseCase(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> call(String productId) async {
    return await repository.getProductReviews(productId);
  }
}