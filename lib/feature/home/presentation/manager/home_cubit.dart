import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entites/CategoryEntity.dart';
import '../../domain/entites/brand_type_entity.dart';
import '../../domain/entites/product_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_brand_types_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetBrandTypesUseCase getBrandTypesUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
    required this.getBrandTypesUseCase,
  }) : super(HomeInitial());

  // تخزين البيانات محلياً لمنع اختفاء التصنيفات عند الفلترة
  List<CategoryEntity> _cachedCategories = [];
  List<BrandTypeEntity> _cachedBrandTypes = [];

  Future<void> fetchHomeData({String? categoryId, String? brandTypeId}) async {
    // إذا كانت القوائم فارغة، نظهر حالة التحميل الكاملة
    if (_cachedCategories.isEmpty) {
      emit(HomeLoading());
    } else {
      // إذا كنا بنفلتر بس، ممكن نظهر Loading خفيف للمنتجات فقط (اختياري)
      emit(HomeLoading());
    }

    try {
      final results = await Future.wait([
        getProductsUseCase.call(categoryId: categoryId, brandTypeId: brandTypeId),
        getCategoriesUseCase.call(),
        getBrandTypesUseCase.call(),
      ]);

      // فك النتائج بشكل آمن مع تحديد النوع الصريح لكل نتيجة
      final productsResult = results[0] as dynamic;
      final categoriesResult = results[1] as dynamic;
      final brandTypesResult = results[2] as dynamic;

      List<ProductEntity> finalProducts = [];
      String? errorMessage;

      // التعامل مع نتائج المنتجات
      productsResult.fold(
            (failure) => errorMessage = failure.errMessage,
            (products) => finalProducts = products as List<ProductEntity>,
      );

      // التعامل مع نتائج التصنيفات (تحديث الكاش)
      categoriesResult.fold(
            (failure) => errorMessage ??= failure.errMessage,
            (categories) => _cachedCategories = categories as List<CategoryEntity>,
      );

      // التعامل مع نتائج أنواع البراندات (تحديث الكاش)
      brandTypesResult.fold(
            (failure) => errorMessage ??= failure.errMessage,
            (brandTypes) => _cachedBrandTypes = brandTypes as List<BrandTypeEntity>,
      );

      if (errorMessage != null) {
        emit(HomeError(errMessage: errorMessage!));
      } else {
        emit(HomeSuccess(
          products: finalProducts,
          categories: _cachedCategories,
          brandTypes: _cachedBrandTypes,
        ));
      }
    } catch (e) {
      emit(HomeError(errMessage: "فشل غير متوقع: ${e.toString()}"));
    }
  }

  // وظيفة مخصصة للفلترة السريعة
  void filterProducts({String? categoryId, String? brandTypeId}) {
    fetchHomeData(categoryId: categoryId, brandTypeId: brandTypeId);
  }
}