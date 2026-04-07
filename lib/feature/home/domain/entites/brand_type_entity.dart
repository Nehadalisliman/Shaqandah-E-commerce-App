import 'package:equatable/equatable.dart';

class BrandTypeEntity extends Equatable {
  final String id;
  final String typeName;
  final String typeImage;

  const BrandTypeEntity({
    required this.id,
    required this.typeName,
    required this.typeImage,
  });

  @override
  // Equatable بنستخدمها عشان نقدر نقارن بين كائنين بسهولة
  List<Object?> get props => [id, typeName, typeImage];
}