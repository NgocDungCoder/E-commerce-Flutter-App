import 'dart:async';

import 'package:ecomercy_app_flutter/views/cart/cart_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/product_service.dart';
import 'product_detail_state.dart';

class ProductDetailLogic extends GetxController {
  final ProductDetailState state = ProductDetailState();
  final ProductService _productService = ProductService();
  final CartLogic _cartLogic = Get.find<CartLogic>();

  @override
  void onInit() async {
    super.onInit();

    state.productId.value = Get.arguments;
    await fetchProductById(state.productId.value);
    await fetchRandomProducts();
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

  // var data = await ProductService().getProducts();
  // products.assignAll(data);
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
      state.isInitialLoading.value = false;
      update();
    }
  }

  Future<void> fetchRandomProducts() async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      List newProducts = await _productService.getRandomProducts();
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
      state.isInitialLoading.value = false;
      update();
    }
  }


  Future<void> refreshProduct(String productID) async {
    state.isInitialLoading.value = true;
    state.products.clear();
    update();
    await fetchProductById(productID);
  }

  void addProducts() async {
    ProductService().addProducts();
  }

  void toggleDropdown() {
    state.isDropdownOpen.value = !state.isDropdownOpen.value;
  }
  void toggleDropdown2(int index) {
    print("trước ${state.isDropdownOpenList[index]}");
    state.isDropdownOpenList[index] = !state.isDropdownOpenList[index];
    print("sau ${state.isDropdownOpenList[index]}");
  }

  void addToCart(String userId, String productId, int quantity) async{
    await _productService.addToCart(userId, productId, quantity);
    _cartLogic.plusCart(quantity);
  }

  void getListProductFromStorage() {
    List products = _cartLogic.getProductListFromStorage();
    print(products);
  }

  void addToStorage(String productId){
    try {
      _cartLogic.addProductIDToStorage(productId);
      print('thêm vào storage thành công');
    } catch (e) {
      print('Lỗi khi thêm vào bộ nhớ: $e');
    }
  }
}
