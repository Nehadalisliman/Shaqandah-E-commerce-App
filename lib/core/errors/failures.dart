abstract class Failure {
  final String errMessage; // لازم نضيف المتغير ده هنا

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
}