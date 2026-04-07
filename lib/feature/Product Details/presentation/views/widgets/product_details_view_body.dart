import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ✅ استخدام الـ Package import لضمان استقرار المسارات
import '../../manager/Product_Details_cubit.dart';
import '../../manager/Product_Details_state.dart';
import 'review_card.dart';

// ✅ تم حذف مكتبات الـ Web نهائياً لضمان بناء الـ APK بنجاح

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsSuccess) {
          final String imageUrl = state.product.mainImage;

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.1,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // ✅ تعديل: استخدام Image.network مباشرة ليعمل على كل المنصات
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.contain,
                                  // مؤشر تحميل احترافي
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          // أزرار الرجوع والمفضلة
                          Positioned(
                            top: 20,
                            left: 16,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildCircularButton(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                                _buildCircularButton(Icons.favorite_border, () {}),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Text(
                            state.product.productName,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          const SizedBox(height: 15),
                          // البراند (اختياري)
                          Text(
                            state.product.brandName,
                            style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Cairo'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildSelectionOutline("Size", "XL"),
                              const SizedBox(width: 15),
                              _buildSelectionOutline("Colour", "", isColor: true),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text("Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                          const SizedBox(height: 12),
                          Text(
                            state.product.description,
                            style: TextStyle(color: Colors.grey[700], height: 1.6, fontSize: 15, fontFamily: 'Cairo'),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Write your review", style: TextStyle(color: Color(0xFFD4AF37), fontFamily: 'Cairo'))
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // قائمة التقييمات
                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.reviews.length,
                            itemBuilder: (context, index) => ReviewCard(review: state.reviews[index]),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              // الجزء السفلي (السعر وزر الإضافة للسلة)
              _buildBottomAction(state.product.price.toString()),
            ],
          );
        } else if (state is ProductDetailsFailure) {
          return Center(child: Text(state.errMessage, style: const TextStyle(color: Colors.red, fontFamily: 'Cairo')));
        } else {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
        }
      },
    );
  }

  // --- الدوال المساعدة ---
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  Widget _buildSelectionOutline(String label, String value, {bool isColor = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$label   ", style: const TextStyle(color: Colors.grey, fontFamily: 'Cairo')),
          isColor
              ? Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          )
              : Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Widget _buildBottomAction(String price) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("PRICE", style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.2, fontFamily: 'Cairo')),
              const SizedBox(height: 4),
              Text("OMR $price", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37), fontFamily: 'Cairo')),
            ],
          ),
          const SizedBox(width: 40),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text("ADD to Cart", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
            ),
          ),
        ],
      ),
    );
  }
}