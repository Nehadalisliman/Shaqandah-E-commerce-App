import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/brand_type_entity.dart';
import '../repos/home_repo.dart'; // مهم جداً للـ Either

class GetBrandTypesUseCase {
  final HomeRepo homeRepo;

  // بنحقن الـ Repo هنا عشان نقدر نستخدمه
  GetBrandTypesUseCase(this.homeRepo);

  // التعديل: تغيير نوع الـ Return ليكون Either ليتوافق مع الـ Repo والـ Cubit
  Future<Either<Failure, List<BrandTypeEntity>>> call() async {
    // طلب البيانات من الـ Repository
    return await homeRepo.getBrandTypes();
  }
}