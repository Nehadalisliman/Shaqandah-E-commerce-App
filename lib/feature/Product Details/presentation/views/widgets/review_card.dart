import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0), // زيادة المسافة لشكل أنظف
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورته الشخصية مع هندلة حالة الخطأ
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[200],
            backgroundImage: review['userImage'] != null && review['userImage'] != ""
                ? NetworkImage(review['userImage'])
                : null,
            child: review['userImage'] == null || review['userImage'] == ""
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),

          // محتوى التقييم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم والنجوم
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review['userName'] ?? 'User Name',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    // الـ Rating Bar الاحترافي
                    RatingBarIndicator( // استخدمنا Indicator لأنه للقراءة فقط (Read Only)
                      rating: (review['rating'] ?? 5).toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Color(0xFFFDB927), // لون نجوم شقندة المميز
                      ),
                      itemCount: 5,
                      itemSize: 14.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // التعليق (الـ Feedback)
                Text(
                  review['comment'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    height: 1.4, // مسافة بين السطور لراحة العين
                  ),
                ),
                const SizedBox(height: 4),

                // إضافة التاريخ (لمسة إضافية للديزاين الجامد)
                Text(
                  "June 5, 2026", // تقدري تربطيها بـ review['date'] لاحقاً
                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}