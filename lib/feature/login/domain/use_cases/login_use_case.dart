import 'package:firebase_auth/firebase_auth.dart';
import '../repos/login_repo.dart';

class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  Future<UserCredential> call({required String email, required String password}) {
    return loginRepo.login(email: email, password: password);
  }
}