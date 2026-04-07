import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_router.dart';
import '../widget/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  // تم تصحيح اسم الـ Constructor ليتطابق مع اسم الكلاس
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            //padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [

                const SizedBox(height: 40),

                // الـ Widget اللي قسمناه في الخطوة السابقة
                const SignUpForm(),

                const SizedBox(height: 20),
                _buildLoginLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return GestureDetector(
      // هنا خليت الصف بالكامل يودي لصفحة الـ Sign Up أو الـ Login حسب احتياجك
      onTap: () => context.push(AppRouter.kLogin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(
              color: Colors.black54,
              // أحياناً بنحتاج نحدد إن الخط ميتغيرش حجمه مع الـ Row
            ),
          ),
          Text(
            "Log in",
            style: TextStyle(
              color: const Color(0xFFFDB927), // اللون الأصفر اللي في الصورة
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}