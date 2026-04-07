import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../domain/entites/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ✅ تم حذف dart:ui_web و dart:html لضمان عمل الـ APK بنجاح

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // الانتقال لصفحة التفاصيل مع تمرير الـ ID
        GoRouter.of(context).push(
          AppRouter.kProductDetails,
          extra: product.productId,
        );
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. حاوية الصورة المحدثة لتعمل على الموبايل والويب
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Stack(
                  children: [
                    // ✅ تم استبدال HtmlElementView بـ Image.network
                    SizedBox.expand(
                      child: Image.network(
                        product.mainImage, // رابط الصورة من الفايربيز
                        fit: BoxFit.cover,
                        // معالجة الخطأ في حال تعذر تحميل الصورة
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey, size: 30),
                        ),
                        // إضافة مؤشر تحميل بسيط
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),

                    // تأثير الظل الجمالي فوق الصورة
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // 2. اسم المنتج
          Text(
            product.productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
              fontFamily: 'Cairo',
            ),
          ),

          // 3. اسم البراند
          Text(
            product.brandName,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontFamily: 'Cairo',
            ),
          ),

          SizedBox(height: 4.h),

          // 4. السعر
          Text(
            "${product.price} OMR",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFFD4AF37), // اللون الذهبي المميز لبراند شقندة
            ),
          ),
        ],
      ),
    );
  }
}