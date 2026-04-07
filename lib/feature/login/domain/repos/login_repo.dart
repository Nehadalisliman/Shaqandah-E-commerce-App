import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepo {
  Future<UserCredential> login({required String email, required String password});
}