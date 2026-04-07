import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ✅ تم حذف dart:ui_web و dart:html نهائياً لضمان بناء الـ APK بنجاح
import '../../domain/entites/CategoryEntity.dart';
import '../manager/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoriesListSection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesListSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // ❌ تم حذف حلقة الـ for الخاصة بـ platformViewRegistry لأنها مخصصة للويب فقط وتسبب أخطاء في الأندرويد

    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "التصنيفات",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo'
            ),
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 110.h, // تعديل الارتفاع ليتناسب مع التصميم الدائري
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () {
                  context.read<HomeCubit>().fetchHomeData(
                    categoryId: category.categoryId,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w), // تعديل الحشو ليتناسب مع الاتجاه العربي
                  child: Column(
                    children: [
                      Container(
                        width: 68.r,
                        height: 68.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34.r),
                          // ✅ استخدام Image.network بدلاً من HtmlElementView
                          child: Image.network(
                            category.categoryImage,
                            fit: BoxFit.cover,
                            // معالجة حالة التحميل
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            // معالجة حالة الخطأ (مثل انقطاع الإنترنت)
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[200],
                              child: Icon(Icons.category, color: Colors.grey, size: 30.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        category.categoryName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}