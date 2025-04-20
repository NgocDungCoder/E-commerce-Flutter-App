import 'dart:async';

import 'package:ecomercy_app_flutter/views/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';

class OrderLogic extends GetxController {
  final state = OrderState();
  late final PageController pageController;
  final ScrollController scrollController = ScrollController();
  final ProductService _productService = ProductService();



  @override
  void onInit() async {
    super.onInit();
    pageController = PageController(initialPage: state.currentTabIndex.value);
    await fetchRandomProducts();
    state.categorizedOrders = Get.arguments['orders'];
    state.currentTabIndex.value = Get.arguments['tabIndex'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.animateToPage(
        state.currentTabIndex.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    });
  }

  Future<void> fetchProductsInOrder(OrderModel order) async {
    List<dynamic> fetchedProducts = [];

    for (var item in order.items) {
      final product = await _productService.getProductById(item.productId);
      if (product != null) {
        product['quantity'] = item.quantity;
        fetchedProducts.add(product);
      }
    }
    print("==================abc============================");
    print(fetchedProducts);
    state.orderProducts[order.id] = fetchedProducts;

  }

  Future<void> fetchProductById(String productID) async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      var newProducts = await _productService.getProductById(productID);
      if (newProducts != null) {
        final imageProvider = NetworkImage(newProducts['image']);
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
        state.product.clear();
        state.product.addAll(newProducts);
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        print(state.product);
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      update();
    }
  }

  Future<void> fetchRandomProducts() async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      List newProducts = await _productService.getRandomProducts(4);
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
        state.products.addAll(newProducts);
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      update();
    }
  }

  // Thay đổi tab khi người dùng chọn
  void changeTab(int index) {
    state.currentTabIndex.value = index;
    pageController.jumpToPage(index); // Chuyển tới page tương ứng
  }



  void animateToTab(int index, dynamic context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = MediaQuery.of(context).size.width * 0.3; // Giả sử mỗi tab rộng 100.0
    double targetOffset = (index * tabWidth) - (screenWidth / 2) + (tabWidth / 2);

    scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 1500),
      curve: Curves.ease,
    );
  }
}
