import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/navigation/app_router.dart';
import '../manager/LoginCubit.dart';
import '../manager/login_state.dart';
import '../widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        // عشان نمنع الـ Overflow لما الكيبورد يفتح
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(AppRouter.kHome);
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating, // شكل أشيك للسناكب بار
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: CustomScrollView(
                // بنستخدم CustomScrollView عشان نضمن إن اللينك اللي تحت بيفضل مكانه صح
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false, // بيخلي المحتوى ياخد المساحة المتاحة بس
                    child: Column(
                      children: [
                        // الفورم بتاخد المساحة اللي فوق
                        Expanded(
                          child: LoginForm(state: state),
                        ),

                        // اللينك بيفضل تحت خالص بشكل ثابت ومريح
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: _buildSignUpLink(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.kSignUp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
              )
          ),
          Text(
            "Sign Up",
            style: TextStyle(
              color: const Color(0xFFFDB927), // لون "شقندة" الأصفر
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}