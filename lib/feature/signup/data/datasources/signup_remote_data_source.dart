import 'package:firebase_auth/firebase_auth.dart';

// بنعمل Interface (Abstract class) عشان نحدد المهام المطلوبة
abstract class SignUpRemoteDataSource {
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  });
}

// التنفيذ الفعلي (Implementation) اللي بيكلم Firebase
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  SignUpRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // 1. إنشاء الحساب باستخدام الإيميل والباسورد
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. تحديث اسم المستخدم (DisplayName) في الفايربيز
      await userCredential.user?.updateDisplayName(name);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // هنا بنرمي الخطأ الخاص بالفايربيز عشان الـ Repository يمسكه
      throw Exception(e.message ?? "حدث خطأ أثناء إنشاء الحساب");
    } catch (e) {
      throw Exception("خطأ غير متوقع: ${e.toString()}");
    }
  }
}