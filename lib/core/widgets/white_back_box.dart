import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// تأكدي أن اسم الكلاس هنا هو نفس الاسم الذي تستدعيه في الفورم (CustomAuthCard)
class CustomAuthCard extends StatelessWidget {
  final Widget child; // 1. تعريف المتغير

  // 2. إضافة المتغير في الـ Constructor وجعله مطلوباً (required)
  const CustomAuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child, // 3. استخدام المتغير هنا لعرض محتويات الفورم
    );
  }
}