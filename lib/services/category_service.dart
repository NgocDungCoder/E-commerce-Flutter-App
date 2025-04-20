import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class CategoryService {
  Future<List<Category>> getAllCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();

      print("snapshot categories count: ${snapshot.docs.length}");

      final allCategories = snapshot.docs.map((doc) => Category.fromDocument(doc)).toList();

      print("Tất cả category lấy được: ${allCategories.map((e) => e.name).toList()}");

      // List tên category muốn lấy
      final selectedNames = ['Áo', 'Váy', 'Giày', 'Đồ ngủ', 'Túi'];

      final selectedCategories = allCategories.where((e) => selectedNames.contains(e.name)).toList();

      print("Category sau khi lọc: ${selectedCategories.map((e) => e.name).toList()}");

      return selectedCategories;
    } catch (e) {
      print("Lỗi khi lấy data trên firebase: $e");
      return [];
    }
  }
}