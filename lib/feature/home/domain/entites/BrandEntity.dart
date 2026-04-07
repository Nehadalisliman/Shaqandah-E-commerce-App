import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String brandId;     // المعرف الخاص بالبراند في الفايربيز
  final String brandName;   // اسم البراند (مثلاً: Adidas)
  final String brandImage;  // رابط الشعار (Logo) ليظهر في الدائرة

  const BrandEntity({
    required this.brandId,
    required this.brandName,
    required this.brandImage,
  });

  // الـ props بتخلي الـ Cubit يعرف لو الداتا اتغيرت ولا لا عشان يعمل Re-build صح
  @override
  List<Object?> get props => [brandId, brandName, brandImage];
}