abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String errMessage;

  // شلت الـ curly braces عشان تنادي عليها كدا: LoginError("حدث خطأ")
  // وده العرف (Convention) المتبع في الـ Bloc
  LoginError(this.errMessage);
}