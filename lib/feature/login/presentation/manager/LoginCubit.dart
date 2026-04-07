import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      // تنفيذ عملية تسجيل الدخول
      await loginUseCase.call(email: email, password: password);

      // لو نجحت، نبعت حالة النجاح
      emit(LoginSuccess());
    } catch (e) {
      // تعديل هنا: نبعت الرسالة مباشرة بدون اسم المعامل (errMessage)
      // لأننا شيلنا الـ {} من كلاس الـ LoginError
      emit(LoginError(e.toString()));
    }
  }
}