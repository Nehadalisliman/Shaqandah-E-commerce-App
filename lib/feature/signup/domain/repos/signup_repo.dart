import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepo {
  // تعريف الدالة اللي أي كلاس "Implementation" لازم ينفذها
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  });
}