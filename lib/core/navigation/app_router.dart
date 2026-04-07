import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ✅ استيراد الـ Cubits والمناجرز المطلوبة
import '../../feature/Product Details/presentation/manager/Product_Details_cubit.dart';
import '../../feature/Product Details/presentation/views/product_details_view.dart';
import '../../feature/home/presentation/manager/home_cubit.dart';
import '../../feature/home/presentation/screens/home_screen.dart';
import '../../feature/login/presentation/manager/LoginCubit.dart'; // تأكدي من المسار
import '../../feature/login/presentation/screens/login_screen.dart';
import '../../feature/signup/presentation/manager/signup_cubit.dart'; // تأكدي من المسار
// تأكدي من المسار

import '../../feature/signup/presentation/screens/signup_screen.dart';
import '../di/service_locator.dart';

class AppRouter {
  static const kLogin = '/';
  static const kSignUp = '/signUp';
  static const kHome = '/home';
  static const kProductDetails = '/productDetails';

  static final router = GoRouter(
    initialLocation: kLogin,
    routes: [
      // 1. مسار تسجيل الدخول (تم إضافة الـ Provider لحل مشكلة الصورة الثانية)
      GoRoute(
        path: kLogin,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),

      // 2. مسار إنشاء الحساب
      GoRoute(
        path: kSignUp,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: const SignUpScreen(),
        ),
      ),

      // 3. مسار الهوم (شقندة)
      GoRoute(
        path: kHome,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<HomeCubit>()..fetchHomeData(),
          child: const HomeScreen(),
        ),
      ),

      // 4. مسار تفاصيل المنتج (حل مشكلة الشاشة الحمراء في الصورة الأولى)
      GoRoute(
        path: kProductDetails,
        builder: (context, state) {
          // استلام الـ ID من الـ extra parameter اللي جاي من صفحة الـ Home
          final String productId = state.extra as String;

          return BlocProvider(
            // استدعاء الـ Cubit وتمرير الـ ID فوراً لجلب البيانات
            create: (context) => getIt<ProductDetailsCubit>()..getProductDetails(productId),
            child: ProductDetailsView(productId: productId),
          );
        },
      ),
    ],

    // صفحة احتياطية في حال حدوث خطأ
    errorBuilder: (context, state) => BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginScreen(),
    ),
  );
}