import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/di/service_locator.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  // 1. التأكد من تهيئة الـ Widgets
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تهيئة الفايربيز
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. تشغيل الـ GetIt (Dependency Injection)
  // تأكدي أن الدالة داخل service_locator لا تحتاج لـ await
  setupServiceLocator();

  runApp(const shoqandafinview());
}

// ✅ تغيير الاسم ليكون احترافياً ويبدأ بحرف كبير (PascalCase)
class shoqandafinview extends StatelessWidget {
  const shoqandafinview({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // مقاس تصميم Figma الخاص بكِ
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Shaqandah',
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,

          // دمج ResponsiveFramework مع ScreenUtil لتجربة ويب ممتازة
          builder: (context, widget) {
            return ResponsiveBreakpoints.builder(
              child: Builder(
                builder: (context) {
                  return Container(
                    color: const Color(0xFFF5F5F5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: MaxWidthBox(
                        maxWidth: 1200,
                        // استخدام widget! لضمان استمرارية شجرة الـ Widgets
                        child: widget!,
                      ),
                    ),
                  );
                },
              ),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              ],
            );
          },
        );
      },
    );
  }
}