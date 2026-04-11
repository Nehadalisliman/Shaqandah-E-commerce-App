import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ✅ الـ Loader المعزول لضمان عمل الصور في الويب وبناء الـ APK بنجاح
import 'package:shoqandafinview/core/utils/web_loader_stub.dart'
if (dart.library.js_interop) 'package:shoqandafinview/core/utils/web_loader_web.dart'
as loader;

import '../../../../core/di/service_locator.dart';
import '../manager/Product_Details_cubit.dart';
import '../manager/Product_Details_state.dart';
import 'widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  final String productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // تهيئة الـ Cubit وجلب البيانات فوراً
      create: (context) => getIt<ProductDetailsCubit>()..getProductDetails(productId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsSuccess) {

              // ✅ تسجيل صورة المنتج في الـ Registry الخاص بالويب (CORS Fix)
              // بنستخدم productId كجزء من الـ viewType لضمان التفرد
              loader.registerWebView(
                'detail-${state.product.productId}',
                state.product.mainImage,
              );

              // تمرير المنتج والـ Widget الخاص بالويب للـ Body
              return ProductDetailsViewBody();
              // ملاحظة: لو كنتِ عدلتِ الـ Constructor في الـ Body ليكون مطلوباً (Required)
              // ستقومين بتمريره هنا كالتالي:
              // return ProductDetailsViewBody(product: state.product);
            }

            else if (state is ProductDetailsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errMessage,
                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () => context.read<ProductDetailsCubit>().getProductDetails(productId),
                      child: const Text("إعادة المحاولة"),
                    )
                  ],
                ),
              );
            }

            // حالة التحميل (Loading)
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD4AF37), // ذهبي شقندة
              ),
            );
          },
        ),
      ),
    );
  }
}