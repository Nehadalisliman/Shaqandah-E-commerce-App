import '../datasources/auth_remote_data_source.dart';
import '../../domain/repos/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepoImpl implements LoginRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  LoginRepoImpl({required this.authRemoteDataSource});

  @override
  Future<UserCredential> login({required String email, required String password}) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }
}