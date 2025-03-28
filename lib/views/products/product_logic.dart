import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomercy_app_flutter/views/products/product_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/scroll_controller.dart';
import '../../services/product_service.dart';

class ProductLogic extends GetxController {
  final ProductService productService = ProductService();
  final ProductState state = ProductState();
  final scrollX = Get.put(ScrollControllerX()); // Khởi tạo controller


  @override
  void onInit() async {
    await fetchProducts(state.currentPage.value);
    await fetchTotalProducts();
    super.onInit();
  }

  void onPageSelected(int pageNumber) {
    state.currentPage.value = pageNumber;
    fetchProducts(pageNumber);
    // scrollController.animateTo(
    //   0.0,
    //   duration: Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
  }
  Future<void> fetchTotalProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('products').get();
    state.totalProducts.value = snapshot.size; // Đếm số lượng sản phẩm
  }


  Future<void> fetchProducts(int page) async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;
    try {
      List newProducts = await productService.fetchProducts(page);
      if (newProducts.isNotEmpty) {
        await Future.wait(newProducts.map((product) async {
          try {
            final imageProvider = NetworkImage(product['image']);
            final completer = Completer<void>();

            imageProvider.resolve(ImageConfiguration()).addListener(
              ImageStreamListener(
                    (imageInfo, _) => completer.complete(),
                onError: (error, stackTrace) {
                  print("⚠️ Lỗi tải ảnh: $error"); // In lỗi nếu ảnh tải thất bại
                  completer.complete();
                },
              ),
            );

            await completer.future;
          } catch (e) {
            print("⚠️ Lỗi khi xử lý ảnh: $e");
          }
        }));
        state.products.clear();
        state.products.addAll(newProducts);
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      state.isInitialLoading.value = false;
      update();
    }
  }

  // Future<void> getTotalPages() async {
  //   int totalProducts = await productService.getTotalProducts();
  //   state.totalPages.value = (totalProducts / productService.pageSize).ceil();
  // }

  Future<void> refreshUser() async {
    state.isInitialLoading.value = true;
    state.products.clear();
    update();
    await fetchProducts(state.currentPage.value);
  }

  // Future<void> fetchProducts({int page = 1}) async {
  //   if (state.isLoading.value) return;
  //   state.isLoading.value = true;
  //   state.currentPage.value = page;
  //
  //   try {
  //     QuerySnapshot querySnapshot = await productService.fetchProducts(page: page);
  //     state.products.assignAll(querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));
  //   } catch (e) {
  //     print('Lỗi khi tải sản phẩm: $e');
  //   }
  //
  //   state.isLoading.value = false;
  // }


  void addProducts() async {
    ProductService().addProducts();
  }
  void toggleListView(){
    state.isListView.value = !state.isListView.value;
  }
}
