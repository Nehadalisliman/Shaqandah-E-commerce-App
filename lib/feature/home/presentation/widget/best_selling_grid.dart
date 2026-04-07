import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entites/product_entity.dart';
import 'product_card.dart';

// ✅ استدعاء مشروط ذكي: للموبايل يستخدم الـ stub وللويب يستخدم ملف الـ web
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
    // 1. عرض حالة القائمة الفارغة بتنسيق Cairo المتوافق مع هوية "شقندة"
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

    // 2. عرض شبكة المنتجات (Grid) بتصميم متجاوب
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.65, // متناسب مع أحجام الشاشات المختلفة لضمان ظهور المحتوى
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return InkWell(
          // ✅ تم التعديل من id إلى productId ليتوافق مع الـ Entity الجديد الخاص بكِ
          onTap: () => onProductTap(product.productId),
          borderRadius: BorderRadius.circular(12.r),
          child: ProductCard(
            product: product,
          ),
        );
      },
    );
  }
}