import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/brand_type_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({String? categoryId, String? brandTypeId});
  Future<List<CategoryModel>> fetchCategories();
  Future<List<BrandTypeModel>> fetchBrandTypes();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;

  HomeRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<ProductModel>> fetchProducts({String? categoryId, String? brandTypeId}) async {
    try {
      Query query = _firestore.collection('Products');

      if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
        query = query.where('categoryId', isEqualTo: categoryId);
      }

      if (brandTypeId != null && brandTypeId.isNotEmpty && brandTypeId != 'all') {
        query = query.where('brandTypeId', isEqualTo: brandTypeId);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        // تعديل هنا: بنبعت الـ data والـ doc.id كبارامترات منفصلة للـ factory الجديد
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

    } on FirebaseException catch (e) {
      throw Exception("Firestore Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: ${e.toString()}");
    }
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('Categories').get();
      return snapshot.docs.map((doc) {
        // تأكدي إن CategoryModel.fromJson بيستقبل الـ ID برضه لو غيرتيه
        return CategoryModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch categories: ${e.toString()}");
    }
  }

  @override
  Future<List<BrandTypeModel>> fetchBrandTypes() async {
    try {
      final snapshot = await _firestore.collection('Brands').get();
      return snapshot.docs.map((doc) {
        return BrandTypeModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch brand types: ${e.toString()}");
    }
  }
}