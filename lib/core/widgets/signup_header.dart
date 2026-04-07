import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // زيادة المسافة فوق العنوان
        SizedBox(height: 50.h),
        Text("Create Account", style: Theme.of(context).textTheme.displayLarge),
        SizedBox(height: 8.h),
        // تعديل النص الترحيبي
        Text("Join Shaqanda family today", style: TextStyle(color: Colors.grey, fontSize: 16.sp)),
        // مسافة بين الـ Header والـ Form
        SizedBox(height: 50.h),
      ],
    );
  }
}