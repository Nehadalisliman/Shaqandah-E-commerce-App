import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/signup_use_case.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  // بنحقن الـ Use Case هنا عشان نستخدمه
  final SignUpUseCase signUpUseCase;

  SignUpCubit(this.signUpUseCase) : super(SignUpInitial());

  // الدالة الأساسية لإنشاء الحساب
  Future<void> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    // 1. أول حاجة بنبعت حالة التحميل (عشان نظهر الـ Spinner في الـ UI)
    emit(SignUpLoading());

    try {
      // 2. بننادي الـ Use Case اللي بيكلم الـ Repo واللي بدوره بيكلم Firebase
      await signUpUseCase.call(
        email: email,
        password: password,
        name: name,
      );

      // 3. لو العملية تمت بدون أخطاء، بنبعت حالة النجاح
      emit(SignUpSuccess());
    } catch (e) {
      // 4. لو حصل أي خطأ (إيميل مكرر مثلاً)، بنبعت حالة الخطأ مع الرسالة
      emit(SignUpError(errMessage: e.toString()));
    }
  }
}
