import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// --- Auth Features ---
import '../../feature/Product Details/presentation/manager/Product_Details_cubit.dart';
import '../../feature/login/data/datasources/auth_remote_data_source.dart';
import '../../feature/login/data/repositories/login_repo_impl.dart';
import '../../feature/login/domain/repos/login_repo.dart';
import '../../feature/login/domain/use_cases/login_use_case.dart';
import '../../feature/login/presentation/manager/LoginCubit.dart';
import '../../feature/signup/data/datasources/signup_remote_data_source.dart';
import '../../feature/signup/data/repositories/signup_repo_impl.dart';
import '../../feature/signup/domain/repos/signup_repo.dart';
import '../../feature/signup/domain/use_cases/signup_use_case.dart';
import '../../feature/signup/presentation/manager/signup_cubit.dart';

// --- Home Feature ---
import '../../feature/home/data/datasources/home_remote_data_source.dart';
import '../../feature/home/data/repositories/home_repo_impl.dart';
import '../../feature/home/domain/repos/home_repo.dart';
import '../../feature/home/domain/use_cases/get_brand_types_use_case.dart';
import '../../feature/home/domain/use_cases/get_categories_use_case.dart';
import '../../feature/home/domain/use_cases/get_products_use_case.dart';
import '../../feature/home/presentation/manager/home_cubit.dart';

// --- Product Details Feature ---
import '../../feature/Product Details/data/datasources/Product_Details_remote_data_source.dart';
import '../../feature/Product Details/data/repositories/Product_Details_repo_impl.dart';
import '../../feature/Product Details/domain/use_cases/GetProductDetailsUseCase.dart';
import '../../feature/Product Details/domain/use_cases/GetProductReviewsUseCase.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // -----------------------------------------------------------------------
  // 1. External Services (Firebase)
  // -----------------------------------------------------------------------
  if (!getIt.isRegistered<FirebaseAuth>()) {
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  }
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }

  // -----------------------------------------------------------------------
  // 2. Auth Features (حل مشكلة LoginCubit is not registered)
  // -----------------------------------------------------------------------

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt<FirebaseAuth>()));
  getIt.registerLazySingleton<SignUpRemoteDataSource>(() => SignUpRemoteDataSourceImpl(getIt<FirebaseAuth>()));

  // Repositories
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(authRemoteDataSource: getIt<AuthRemoteDataSource>()));
  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepoImpl(signUpRemoteDataSource: getIt<SignUpRemoteDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt<LoginRepo>()));
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(signUpRepo: getIt<SignUpRepo>()));

  // Cubits
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUseCase>()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<SignUpUseCase>()));

  // -----------------------------------------------------------------------
  // 3. Home Feature
  // -----------------------------------------------------------------------
  getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(homeRemoteDataSource: getIt<HomeRemoteDataSource>()));

  getIt.registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(getIt<HomeRepo>()));
  getIt.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(getIt<HomeRepo>()));
  getIt.registerLazySingleton<GetBrandTypesUseCase>(() => GetBrandTypesUseCase(getIt<HomeRepo>()));

  getIt.registerFactory<HomeCubit>(() => HomeCubit(
    getProductsUseCase: getIt<GetProductsUseCase>(),
    getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
    getBrandTypesUseCase: getIt<GetBrandTypesUseCase>(),
  ));

  // -----------------------------------------------------------------------
  // 4. Product Details Feature
  // -----------------------------------------------------------------------
// -----------------------------------------------------------------------
// 4. Product Details Feature - داخل setup_service_locator.dart
// -----------------------------------------------------------------------

// 1. Data Source
  if (!getIt.isRegistered<ProductDetailsRemoteDataSource>()) {
    getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
          () => ProductDetailsRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
    );
  }

// 2. Repository
// ✅ تأكدي من استيراد الـ Interface (ProductDetailsRepo)
// وربطه بالـ Impl (ProductDetailsRepoImpl)
  if (!getIt.isRegistered<ProductDetailsRepo>()) {
    getIt.registerLazySingleton<ProductDetailsRepo>(
          () => ProductDetailsRepoImpl(
        productDetailsRemoteDataSource: getIt<ProductDetailsRemoteDataSource>(),
      ),
    );
  }

// 3. Use Cases
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
        () => GetProductDetailsUseCase(getIt<ProductDetailsRepo>()),
  );

  getIt.registerLazySingleton<GetProductReviewsUseCase>(
        () => GetProductReviewsUseCase(getIt<ProductDetailsRepo>()),
  );

// 4. Cubit
// ✅ تمرير المتغيرات بالأسماء المطلوبة في الـ Constructor
  getIt.registerFactory<ProductDetailsCubit>(
        () => ProductDetailsCubit(
      getProductDetailsUseCase: getIt<GetProductDetailsUseCase>(),
      getProductReviewsUseCase: getIt<GetProductReviewsUseCase>(),
    ),
  );
}