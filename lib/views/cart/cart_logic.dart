import 'dart:async';

import 'package:ecomercy_app_flutter/views/cart/cart_state.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../services/product_service.dart';
import 'package:flutter/material.dart';


class CartLogic extends GetxController {
  final ProductService _productService = ProductService();
  final CartState state = CartState();
  final GetStorage storage = GetStorage();
  String userId = 'zYhe1dcYsDcr4qGcwKWg';

  @override
  void onInit() async {
    super.onInit();
    await fetchCardOfUser('zYhe1dcYsDcr4qGcwKWg');
  }

  Future<void> fetchCardOfUser(String userId) async {
    if (state.isLoading.value) {

      List cartProducts = await _productService.getCartOfUser(userId);
      if (cartProducts.isNotEmpty) {

        await Future.wait(cartProducts.map((product) async {}));
        state.productsOfCart.clear();
        state.productsOfCart.addAll(cartProducts);
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        print(state.productsOfCart.runtimeType);
        updateCartItemCount();

        print(state.itemCount.value);
        getCartDetail();
        state.isLoading.value = false;
        state.isIndicatorLoding.value = false;
      }
    }
  }

  void getCartDetail() async {
    List cartItems = state.productsOfCart;
    try {
      for (var item in cartItems) {
        String productId = item['productID'];
        int quantity = item['quantity'];
        String cartID = item['cartID'];
        Map<String, dynamic>? productData =
            await _productService.getProductById(productId);
        if (productData != null) {
          productData['quantity'] = quantity;
          productData['cardID'] = cartID;
          state.subTotal += productData['price'] * quantity;
          state.productsDetail.add(productData);
        }
      }
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
    }
  }

  void updateQuantityItem(String cartId, int newQuantity) async {
    if (newQuantity > 0) {
      state.isLoading.value = true;
      await _productService.updateCartItemQuantity(userId, cartId, newQuantity);
      state.itemCount.value = 0;
      state.subTotal.value = 0;
      state.productsDetail.value = [];
      await fetchCardOfUser('zYhe1dcYsDcr4qGcwKWg');
    } else {
      showDeleteDialog(cartId);
    }
  }

  List<String> getProductList() {
    List<dynamic>? storedIDs = storage.read<List<dynamic>>('cart_product_ids');
    return storedIDs?.map((id) => id.toString()).toList() ?? [];
  }

  void removeProductID(String productID) {
    List<String> productIDs = getProductList();
    productIDs.removeWhere((id) => id == productID); // Xóa tất cả phần tử trùng
    storage.write('cart_product_ids', productIDs);
  }
  void updateCartItemCount() async{
    try {
      List cartItems = state.productsOfCart;
      //kiểm tra số lượng mặt hàng
      int totalCount = 0;
      for (var doc in cartItems) {
        totalCount += (doc["quantity"] as int);
      }
      //chỉ lấy số loại hàng: cartSnapshot.docs.length
      state.itemCount.value = totalCount;
    } catch (e) {
      state.itemCount.value = 0;
    }
  }

  void addProductIDToStorage(String productID) {
    List<dynamic>? storedIDs = storage.read<List<dynamic>>('cart_product_ids');
    List<String> productIDs = storedIDs?.map((id) => id.toString()).toList() ?? [];

    if (!productIDs.contains(productID)) {
      productIDs.add(productID);
      storage.write('cart_product_ids', productIDs);
    }
  }

  List<String> getProductListFromStorage() {
    List<dynamic>? storedIDs = storage.read<List<dynamic>>('cart_product_ids');
    return storedIDs?.map((id) => id.toString()).toList() ?? [];
  }

  Future<void> refreshCart() async {
    state.isLoading.value = true;
    state.isIndicatorLoding.value = true;
    state.itemCount.value = 0;
    state.subTotal.value = 0;
    state.productsDetail.value = [];
    print('chạy vô refresh');
    await fetchCardOfUser('zYhe1dcYsDcr4qGcwKWg');
  }

  void showDeleteDialog(String cartId) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, size: 50, color: Colors.red),
              SizedBox(height: 10),
              Text(
                "Xác nhận xóa?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Bạn có chắc muốn xóa sản phẩm khỏi giỏ hàng?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                    ),
                    child: Text("Hủy", style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _productService.deleteProductFromCart(
                          cartId, userId);
                      refreshCart();
                      Future.delayed(Duration(milliseconds: 200), () {
                        Get.snackbar(
                          "Thành công",
                          "Sản phẩm đã được xóa khỏi giỏ hàng!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: Duration(seconds: 1),
                        );
                      });
                      Get.back(); // Đóng dialog
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.red,
                      elevation: 2,
                    ),
                    child: Text("Xóa", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Bắt buộc người dùng chọn "Hủy" hoặc "Xóa"
    );
  }
}
