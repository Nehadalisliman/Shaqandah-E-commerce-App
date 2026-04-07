import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repos/signup_repo.dart';
import '../datasources/signup_remote_data_source.dart';



class SignUpRepoImpl implements SignUpRepo {
  final SignUpRemoteDataSource signUpRemoteDataSource;

  SignUpRepoImpl({required this.signUpRemoteDataSource});

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // بننادي الـ Data Source اللي عملناه الخطوة اللي فاتت
      final userCredential = await signUpRemoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
      );

      return userCredential;
    } on Exception catch (e) {
      // هنا بنعيد تمرير الخطأ عشان الـ Cubit يمسكه ويعرضه في الـ UI
      throw Exception(e.toString());
    }
  }
}