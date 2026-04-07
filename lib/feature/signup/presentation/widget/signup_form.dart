import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/CustomInputField.dart';
import '../../../../core/widgets/white_back_box.dart';

// تأكدي من مسار الـ Widget اللي جواه الـ Box الأبيض

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Padding خفيف عشان الـ Box ميبقاش لازق في الشاشة
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),

            // استخدام الـ Box الأبيض لتغليف الفورم بالكامل
            CustomAuthCard( // اتأكدي إن اسم الكلاس جوه الملف هو WhiteBackBox أو CustomAuthCard
              child: Column(
                children: [
                  CustomInputField(
                      label: 'Name',
                      controller: nameController,
                      hint: 'David Spade'
                  ),
                  SizedBox(height: 16.h),

                  CustomInputField(
                      label: 'Email',
                      controller: emailController,
                      hint: 'd.spade@example.com',
                      keyboardType: TextInputType.emailAddress
                  ),
                  SizedBox(height: 16.h),

                  CustomInputField(
                      label: 'Password',
                      controller: passwordController,
                      hint: '••••••••',
                      isPassword: true
                  ),
                  SizedBox(height: 16.h),


                  SizedBox(height: 32.h),

                  _buildSignUpButton(),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // تنفيذ الأكشن هنا
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)
          ),
          elevation: 0,
        ),
        child: Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp
            )
        ),
      ),
    );
  }
}