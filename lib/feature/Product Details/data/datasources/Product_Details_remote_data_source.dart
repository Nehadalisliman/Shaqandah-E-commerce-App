import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/data/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  // 1. جلب بيانات منتج معين بالـ ID (لو احتجنا تحديث البيانات)
  Future<ProductModel> getProductDetails(String productId);

  // 2. جلب التقييمات الخاصة بهذا المنتج (لأنها Collection منفصل جوه المنتج)
  Future<List<Map<String, dynamic>>> getProductReviews(String productId);
}

class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource {
  final FirebaseFirestore _firestore;

  ProductDetailsRemoteDataSourceImpl(this._firestore);

  @override
  Future<ProductModel> getProductDetails(String productId) async {
    try {
      // الوصول لمستند المنتج مباشرة باستخدام الـ ID
      final doc = await _firestore.collection('Products').doc(productId).get();

      if (doc.exists) {
        // تحويل الداتا لموديل باستخدام الـ factory اللي عملناه
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        throw Exception("Product not found");
      }
    } catch (e) {
      throw Exception("Error fetching product details: $e");
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getProductReviews(String productId) async {
    try {
      // الدخول لكولكشن 'Reviews' اللي جوه المنتج (Sub-collection)
      final snapshot = await _firestore
          .collection('Products')
          .doc(productId)
          .collection('Reviews')
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Error fetching reviews: $e");
    }
  }
}