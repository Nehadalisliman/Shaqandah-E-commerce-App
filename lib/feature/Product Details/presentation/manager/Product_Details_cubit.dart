import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/GetProductDetailsUseCase.dart';
import '../../domain/use_cases/GetProductReviewsUseCase.dart';
import 'Product_Details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final GetProductReviewsUseCase getProductReviewsUseCase;

  ProductDetailsCubit({
    required this.getProductDetailsUseCase,
    required this.getProductReviewsUseCase,
  }) : super(ProductDetailsInitial());

  // 👇 هنا بنحط الكود اللي سألتي عنه
  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());

    final productResult = await getProductDetailsUseCase.call(productId);
    final reviewsResult = await getProductReviewsUseCase.call(productId);

    productResult.fold(
          (failure) => emit(ProductDetailsFailure(errMessage: failure.errMessage)),
          (product) {
        reviewsResult.fold(
              (failure) => emit(ProductDetailsFailure(errMessage: failure.errMessage)),
              (reviews) {
            emit(ProductDetailsSuccess(product: product, reviews: reviews));
          },
        );
      },
    );
  }
}