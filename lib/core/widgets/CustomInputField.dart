import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500], // لون رمادي فاتح للـ Label
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        // شلنا الـ SizedBox الصغير عشان نقرب الخط من النص زي الصورة
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          validator: validator,
          cursorColor: const Color(0xFF66BB91), // لون المؤشر أخضر هادئ
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.greey),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h), // مسافة رأسية بسيطة

            // التعديل الأساسي هنا: استخدام UnderlineInputBorder بدل Outline
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF66BB91), width: 2.0), // خط أخضر عند الضغط
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}