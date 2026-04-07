import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/CustomInputField.dart';
import '../../../../core/widgets/white_back_box.dart';
import '../manager/LoginCubit.dart';
import '../manager/login_state.dart';

class LoginForm extends StatefulWidget {
  final LoginState state;
  const LoginForm({super.key, required this.state});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Text(
              "Welcome,",
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Sign in to Continue",
              style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
            ),
            SizedBox(height: 40.h),

            // البوكس الأبيض المحتوي على المدخلات
            CustomAuthCard(
              child: Column(
                children: [
                  CustomInputField(
                    label: "Phone Number or Email",
                    controller: emailController,
                    hint: 'example@mail.com',
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 20.h),
                  CustomInputField(
                    label: "Password",
                    controller: passwordController,
                    hint: '••••••••',
                    isPassword: true,
                    validator: (v) => v!.length < 6 ? "Too short" : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // أكشن نسيت كلمة المرور
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: widget.state is LoginLoading
            ? null
            : () {
          if (formKey.currentState!.validate()) {
            context.read<LoginCubit>().login(
              email: emailController.text.trim(),
              password: passwordController.text,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
        ),
        child: widget.state is LoginLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        )
            : Text(
          "SIGN IN",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
} // القوس ده هو اللي كان ناقص عشان يقفل الكلاس