import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../manager/Product_Details_cubit.dart';
import '../../manager/Product_Details_state.dart';
import 'review_card.dart';

// ✅ استدعاء الـ Loader المعزول (السر في ظهور الصور بالويب وأمان الـ APK)
import 'package:shoqandafinview/core/utils/web_loader_stub.dart'
if (dart.library.js_interop) 'package:shoqandafinview/core/utils/web_loader_web.dart'
as loader;

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsSuccess) {
          final product = state.product;

          // ✅ تسجيل هوية الصورة للويب (CORS Fix)
          loader.registerWebView('detail-${product.productId}', product.mainImage);

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
                              margin: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                // ✅ استخدام المنطق المزدوج (ويب/موبايل)
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (identical(0, 0.0)) { // شرط الويب الآمن
                                      return HtmlElementView(viewType: 'detail-${product.productId}');
                                    }
                                    return Image.network(
                                      product.mainImage,
                                      fit: BoxFit.contain,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
                                      },
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          // أزرار الرجوع والمفضلة
                          Positioned(
                            top: 40.h,
                            left: 16.w,
                            right: 16.w,
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Text(
                            product.productName,
                            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            product.brandName,
                            style: TextStyle(fontSize: 16.sp, color: Colors.grey, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              _buildSelectionOutline("Size", "XL"),
                              SizedBox(width: 15.w),
                              _buildSelectionOutline("Colour", "", isColor: true),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          Text("Details", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                          SizedBox(height: 12.h),
                          Text(
                            product.description,
                            style: TextStyle(color: Colors.grey[700], height: 1.6, fontSize: 15.sp, fontFamily: 'Cairo'),
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Reviews", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Write your review", style: TextStyle(color: Color(0xFFD4AF37), fontFamily: 'Cairo'))
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
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
              _buildBottomAction(product.price.toString()),
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

  // الدوال المساعدة (تظل كما هي مع إضافة ScreenUtil للأبعاد)
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Icon(icon, size: 18.sp, color: Colors.black),
      ),
    );
  }

  Widget _buildSelectionOutline(String label, String value, {bool isColor = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$label   ", style: const TextStyle(color: Colors.grey, fontFamily: 'Cairo')),
          isColor
              ? Container(width: 18.r, height: 18.r, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle))
              : Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        ],
      ),
    );
  }

  Widget _buildBottomAction(String price) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PRICE", style: TextStyle(color: Colors.grey, fontSize: 11.sp, letterSpacing: 1.2, fontFamily: 'Cairo')),
              SizedBox(height: 4.h),
              Text("OMR $price", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xFFD4AF37), fontFamily: 'Cairo')),
            ],
          ),
          SizedBox(width: 40.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text("ADD to Cart", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
            ),
          ),
        ],
      ),
    );
  }
}