import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';  // Đảm bảo bạn import thư viện này
import 'package:ecomercy_app_flutter/services/order_service.dart';
import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_detail_state.dart';

class OrderDetailLogic extends GetxController {
  final orderService = OrderService();
  final state = OrderDetailState();
  final _productService = ProductService();


  @override
  void onInit() async {
    super.onInit();
    print("đã vô được init");

    state.orderID.value = Get.arguments;
    print(state.orderID);
    await getOrderById(state.orderID.value);
    await fetchRandomProducts();
  }

  Future<void> getOrderById(String orderId) async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      var newOrders =
          await orderService.getOrderById("zYhe1dcYsDcr4qGcwKWg", orderId);
      if (newOrders != null) {
        state.productsOfOrder.clear();
        state.productsOfOrder.addAll(newOrders['items']);
        state.order.clear();
        state.order.addAll(newOrders);
        getOrderDetail();
        state.isLoading.value = false;
        // state.isIndicatorLoding.value = false;
        print('order đã tải về');
        print(state.order);
        state.subToTal.value = state.order['totalAmount'].toDouble();
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      update();
    }
  }

  //ko tối ưu bằng
  // void getOrderDetail() async {
  //   List orderItems = state.productsOfOrder;
  //   try {
  //     for (var item in orderItems) {
  //       String productId = item['productID'];
  //       int quantity = item['quantity'];
  //       Map<String, dynamic>? productData =
  //           await _productService.getProductById(productId);
  //       if (productData != null) {
  //         print("Trước");
  //         print(state.productsDetail);
  //         productData['quantity'] = quantity;
  //         state.productsDetail.add(productData);
  //         try {
  //           final imageProvider = NetworkImage(productData['image']);
  //           final completer = Completer<void>();
  //
  //           imageProvider.resolve(ImageConfiguration()).addListener(
  //             ImageStreamListener(
  //                   (imageInfo, _) => completer.complete(),
  //               onError: (error, stackTrace) {
  //                 print("⚠️ Lỗi tải ảnh: $error"); // In lỗi nếu ảnh tải thất bại
  //                 completer.complete();
  //               },
  //             ),
  //           );
  //
  //           await completer.future;
  //         } catch (e) {
  //           print("⚠️ Lỗi khi xử lý ảnh: $e");
  //         }
  //         print("Sau");
  //         print(state.productsDetail);
  //       }
  //     }
  //   } catch (e) {
  //     print('Lỗi khi lấy sản phẩm: $e');
  //   }
  //
  // }
  void getOrderDetail() async {
    final orderItems = state.productsOfOrder;

    try {
      // Load tất cả products song song
      final productsData = await Future.wait(orderItems.map((item) async {
        try {
          final productId = item['productID'];
          final quantity = item['quantity'];

          final productData = await _productService.getProductById(productId);

          if (productData == null) return {}; // Skip nếu null
          productData['quantity'] = quantity;

          // Check ảnh có load được không
          try {
            final imageProvider = NetworkImage(productData['image']);
            final completer = Completer<void>();

            imageProvider.resolve(const ImageConfiguration()).addListener(
              ImageStreamListener(
                    (imageInfo, _) => completer.complete(),
                onError: (error, stackTrace) {
                  print("⚠️ Lỗi tải ảnh: $error");
                  completer.complete();
                },
              ),
            );

            await completer.future;
          } catch (e) {
            print("⚠️ Lỗi khi xử lý ảnh: $e");
          }

          return productData;
        } catch (e) {
          print('⚠️ Lỗi khi xử lý product: $e');
          return {}; // Return rỗng nếu có lỗi
        }
      }));

      // Lọc bỏ data rỗng (nếu có product bị lỗi)
      state.productsDetail.addAll(productsData.where((e) => e.isNotEmpty));

      print("🔥 Danh sách product detail: ${state.productsDetail}");
    } catch (e) {
      print('❌ Lỗi khi lấy sản phẩm: $e');
    }
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  void copyToClipboard(BuildContext context) {
    // Sao chép chuỗi vào clipboard
    Clipboard.setData(ClipboardData(text: state.orderID.value));

    // Hiển thị thông báo xác nhận khi sao chép thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã sao chép: ${state.orderID.value}'), duration: Duration(seconds: 1),),
    );
  }

  Future<void> fetchRandomProducts() async {
    if (state.isLoading.value) return;
    state.isLoading.value = true;

    try {
      List newProducts = await _productService.getRandomProducts(6);
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
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
    } finally {
      state.isLoading.value = false;
      update();
    }
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
