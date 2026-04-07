import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ✅ تم حذف مكتبات الـ Web نهائياً لضمان بناء الـ APK
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

  // ✅ تم حذف دالة _registerBrandImages وكل ما يتعلق بـ platformViewRegistry

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
          height: 50.h, // تعديل الارتفاع ليتناسب مع الكروت الجديدة
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.brandTypes.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final type = widget.brandTypes[index];

              return BrandTypeCard(
                title: type.typeName,
                // ✅ نمرر الرابط مباشرة والـ BrandTypeCard هو اللي هيعرضه بـ Image.network
                imageUrl: type.typeImage,
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  context.read<HomeCubit>().fetchHomeData(
                    brandTypeId: type.id,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}