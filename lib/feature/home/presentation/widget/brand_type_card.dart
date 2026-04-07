import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ✅ تم حذف مكتبة dart:ui_web لتمكين بناء الـ APK بنجاح

class BrandTypeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const BrandTypeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 155.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.grey.withOpacity(0.15),
            width: isSelected ? 1.8.w : 1.w,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          children: [
            // حاوية الصورة المحدثة
            SizedBox(
              width: 32.w,
              height: 32.h,
              child: _buildImage(imageUrl),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFFD4AF37) : Colors.black87,
                  fontFamily: 'Cairo',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    if (url.isEmpty || !url.startsWith('http')) {
      return Icon(Icons.category_outlined, size: 20.sp, color: Colors.grey);
    }

    // ✅ استخدام Image.network بدلاً من HtmlElementView لدعم الأندرويد
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        // إضافة مؤشر تحميل بسيط
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 15.w,
              height: 15.h,
              child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFD4AF37)),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.broken_image_outlined, size: 20.sp, color: Colors.grey),
      ),
    );
  }
}