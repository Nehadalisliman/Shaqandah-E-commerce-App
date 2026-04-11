import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ✅ الـ Loader المعزول (استخدامه فقط يمنع الـ Build Errors)
import 'package:shoqandafinview/core/utils/web_loader_stub.dart'
if (dart.library.js_interop) 'package:shoqandafinview/core/utils/web_loader_web.dart'
as loader;

import '../../domain/entites/CategoryEntity.dart';
import '../manager/home_cubit.dart';

class CategoriesListSection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesListSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
          height: 115.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              // ✅ استخدام الدالة المعزولة لتسجيل الصور (آمنة للأندرويد)
              loader.registerWebView('cat-${category.categoryId}', category.categoryImage);

              return GestureDetector(
                onTap: () {
                  context.read<HomeCubit>().fetchHomeData(
                    categoryId: category.categoryId,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
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
                          child: Stack(
                            children: [
                              SizedBox.expand(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    // التحقق لو إحنا ويب بطريقة لا تكسر الموبايل
                                    if (identical(0, 0.0)) {
                                      return HtmlElementView(viewType: 'cat-${category.categoryId}');
                                    }

                                    return CachedNetworkImage(
                                      imageUrl: category.categoryImage,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFD4AF37)),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.category_outlined, size: 30.r),
                                    );
                                  },
                                ),
                              ),
                            ],
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