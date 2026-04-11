import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/navigation/app_router.dart';
import '../../domain/entites/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final Widget? imageWidget; // لاستقبال الـ HtmlElementView في الويب

  const ProductCard({
    super.key,
    required this.product,
    this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // الانتقال لصفحة التفاصيل
        GoRouter.of(context).push(
          AppRouter.kProductDetails,
          extra: product.productId,
        );
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- الجزء الخاص بالصورة ---
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
                    SizedBox.expand(
                      child: imageWidget ?? CachedNetworkImage(
                        imageUrl: product.mainImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFD4AF37),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey, size: 30),
                        ),
                      ),
                    ),
                    // تأثير تدرج خفيف لجعل التصميم يبدو "Premium"
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.03),
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

          SizedBox(height: 10.h),

          // --- تفاصيل المنتج ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  product.brandName,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "${product.price} OMR",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFD4AF37), // ذهبي شقندة
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}