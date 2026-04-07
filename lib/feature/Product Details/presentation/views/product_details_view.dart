import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/Product_Details_cubit.dart';
import 'widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  final String productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // بنجيب الـ Cubit ونشغل الدالة فوراً بالـ ID
      create: (context) => getIt<ProductDetailsCubit>()..getProductDetails(productId),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: ProductDetailsViewBody(),
      ),
    );
  }
}