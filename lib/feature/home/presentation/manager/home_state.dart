
import '../../domain/entites/CategoryEntity.dart';
import '../../domain/entites/brand_type_entity.dart';
import '../../domain/entites/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

// حالة التحميل الخاصة بالمنتجات فقط (عشان لما نفلتر الكاتجوري متختفيش)
class HomeProductsLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final List<BrandTypeEntity> brandTypes;

  HomeSuccess({
    required this.products,
    required this.categories,
    required this.brandTypes,
  });
}

class HomeError extends HomeState {
  final String errMessage;

  HomeError({required this.errMessage});
}