import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entites/product_entity.dart';
import 'product_card.dart';

// ✅ استدعاء الـ Loader المعزول لتجنب أخطاء بناء الـ APK
import 'package:shoqandafinview/core/utils/web_loader_stub.dart'
if (dart.library.js_interop) 'package:shoqandafinview/core/utils/web_loader_web.dart'
as loader;

class BestSellingGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final Function(String productId) onProductTap;

  const BestSellingGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inventory_2_outlined, color: Colors.grey[300], size: 50.sp),
              SizedBox(height: 12.h),
              Text(
                "لا توجد منتجات حالياً",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo'
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        // ✅ تسجيل صورة المنتج للويب باستخدام الـ viewId الفريد (CORS Solution)
        loader.registerWebView('prod-${product.productId}', product.mainImage);

        return ProductCard(
          product: product,
          // ✅ تمرير الـ HtmlElementView لاستخدامه في الويب
          imageWidget: HtmlElementView(viewType: 'prod-${product.productId}'),
        );
      },
    );
  }
}