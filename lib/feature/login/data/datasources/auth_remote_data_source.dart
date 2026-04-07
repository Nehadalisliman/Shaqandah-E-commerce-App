import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  AuthRemoteDataSourceImpl(this.auth);

  @override
  Future<UserCredential> login({required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }
}