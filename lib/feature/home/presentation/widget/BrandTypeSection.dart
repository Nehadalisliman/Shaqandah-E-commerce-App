import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ✅ الـ Loader المعزول لحماية الموبايل من أخطاء الويب
import 'package:shoqandafinview/core/utils/web_loader_stub.dart'
if (dart.library.js_interop) 'package:shoqandafinview/core/utils/web_loader_web.dart'
as loader;

import '../../domain/entites/brand_type_entity.dart';
import '../manager/home_cubit.dart';
import 'brand_type_card.dart';

class BrandTypeSection extends StatefulWidget {
  final List<BrandTypeEntity> brandTypes;

  const BrandTypeSection({super.key, required this.brandTypes});

  @override
  State<BrandTypeSection> createState() => _BrandTypeSectionState();
}

class _BrandTypeSectionState extends State<BrandTypeSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.brandTypes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "نوع البراند",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo'
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 60.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.brandTypes.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final type = widget.brandTypes[index];

              // ✅ تسجيل صورة البراند للويب بطريقة آمنة تماماً للموبايل
              loader.registerWebView('brand-${type.id}', type.typeImage);

              return ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: BrandTypeCard(
                  title: type.typeName,
                  imageUrl: type.typeImage,
                  isSelected: selectedIndex == index,
                  // ✅ تمرير الـ HtmlElementView فقط في حالة الويب
                  webImage: SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: HtmlElementView(viewType: 'brand-${type.id}'),
                  ),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    context.read<HomeCubit>().fetchHomeData(
                      brandTypeId: type.id,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}