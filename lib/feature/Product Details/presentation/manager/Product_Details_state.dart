import 'package:equatable/equatable.dart';

import '../../../home/domain/entites/product_entity.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

// 1. حالة البداية (قبل ما ننده على أي داتا)
class ProductDetailsInitial extends ProductDetailsState {}

// 2. حالة التحميل (لما الدائرة بتلف)
class ProductDetailsLoading extends ProductDetailsState {}

// 3. حالة النجاح (لما الداتا تيجي بالسلامة)
class ProductDetailsSuccess extends ProductDetailsState {
  final ProductEntity product;
  final List<Map<String, dynamic>> reviews;

  const ProductDetailsSuccess({required this.product, required this.reviews});

  @override
  List<Object?> get props => [product, reviews];
}

// 4. حالة الفشل (لو حصل مشكلة في النت أو الفايربيز)
class ProductDetailsFailure extends ProductDetailsState {
  final String errMessage;

  const ProductDetailsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}