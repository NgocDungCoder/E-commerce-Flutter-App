import 'dart:async';

import 'package:ecomercy_app_flutter/services/category_service.dart';
import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:ecomercy_app_flutter/views/main/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final state = HomeState();
  final _productService = ProductService();
  final _categoryService = CategoryService();
  late final PageController pageController;


  @override
  void onInit() async {
    super.onInit();
    await fetchRandomProducts();
    pageController = PageController(initialPage: state.currentTabIndex.value);
    await fetchData();
  }

  Future<void> fetchRandomProducts() async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      List newProducts = await _productService.getRandomProducts(5);
      if (newProducts.isNotEmpty) {
        await Future.wait(newProducts.map((product) async {
          final imageProvider = NetworkImage(product['image']);
          final completer = Completer<void>();

          imageProvider.resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
                  (imageInfo, _) => completer.complete(),
              onError: (error, stackTrace) {
                print(
                    "⚠️ Lỗi tải ảnh: $error"); // In lỗi nếu ảnh tải thất bại
                completer.complete();
              },
            ),
          );

          await completer.future;
        }));
        print("*****************************************");
        state.products.addAll(newProducts);
        print(state.products);
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      update();
    }
  }

  Future<void> fetchData() async {
    state.isLoading2.value = true;
    print("đã vào fetchData");
    try {
      final categories = await _categoryService.getAllCategories();
      state.categories(categories);
    } on Exception catch (e) {
      print("Lỗi khi lấy category: $e");
    }


    final categoriesTemp = state.categories.toList();

    for (var category in categoriesTemp) {
      final products = await _productService.getProductsByCategory(categoryId: category.id);
      state.productsByCategory[category.id] = products;
      print("************************************");
      print(state.productsByCategory);
    }
    state.isLoading2.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    update(); // Cập nhật UI ngay sau khi controller sẵn sàng
  }

}