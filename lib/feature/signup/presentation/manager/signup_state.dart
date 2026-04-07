abstract class SignUpState {}

// 1. الحالة الابتدائية: أول ما المستخدم يفتح الصفحة
class SignUpInitial extends SignUpState {}

// 2. حالة التحميل: لما المستخدم يدوس على الزرار ونستنى رد الفايربيز
class SignUpLoading extends SignUpState {}

// 3. حالة النجاح: لما الحساب يتكريه فعلاً
class SignUpSuccess extends SignUpState {}

// 4. حالة الخطأ: لو حصلت مشكلة (إيميل متكرر، نت ضعيف، إلخ)
class SignUpError extends SignUpState {
  final String errMessage;

  SignUpError({required this.errMessage});
}