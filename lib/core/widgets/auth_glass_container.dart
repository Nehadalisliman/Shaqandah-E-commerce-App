import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // عشان المسافات تكون مظبوطة على كل الشاشات
// تأكدي من مسار ملف الألوان

class AuthGlassContainer extends StatelessWidget {
  final Widget child; // بنبعت الـ widgets اللي جوا المربع الأبيض كـ child

  const AuthGlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // بياخد عرض الشاشة كله
      padding: EdgeInsets.symmetric(
        horizontal: 20.w, // مسافة 20 من الجانبين (استخدمت w من ScreenUtilInit)
        vertical: 30.h,   // مسافة 30 من فوق وتحت
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w), // مسافة من حافة الشاشة
      decoration: BoxDecoration(
        color: Colors.white, // اللون الأبيض
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r), // حواف دائرية خفيفة من فوق
          topRight: Radius.circular(10.r),
          // يمكنك إضافة حواف دائرية من الأسفل لو تحبين
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // ظل خفيف جداً عشان يدي عمق
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child, // بنحط الـ child هنا (اللي هو الـ Column اللي فيه الداتا)
    );
  }
}