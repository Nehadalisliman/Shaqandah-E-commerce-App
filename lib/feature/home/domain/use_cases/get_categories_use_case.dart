import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/CategoryEntity.dart';
import '../repos/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepo homeRepo;

  GetCategoriesUseCase(this.homeRepo);

  // التعديل: تغيير نوع الـ Return ليكون Either ليتوافق مع الـ Repo
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    // طلب التصنيفات من الـ Repository
    return await homeRepo.getCategories();
  }
}