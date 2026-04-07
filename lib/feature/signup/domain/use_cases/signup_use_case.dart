import 'package:firebase_auth/firebase_auth.dart';

import '../repos/signup_repo.dart';

class SignUpUseCase {
  final SignUpRepo signUpRepo;

  SignUpUseCase({required this.signUpRepo});

  // الدالة اللي الـ Cubit هيناديها
  Future<UserCredential> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return await signUpRepo.signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}