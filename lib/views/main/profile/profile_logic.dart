import 'dart:async';

import 'package:ecomercy_app_flutter/services/product_service.dart';
import 'package:ecomercy_app_flutter/views/main/profile/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/order_controller.dart';
import '../../../models/order_model.dart';
import '../../../utils/printLog.dart';

class ProfileLogic extends GetxController {
  final state = ProfileState();
  final _productService = ProductService();
  final orderController = Get.find<OrderController>();
  String currentUserId = "zYhe1dcYsDcr4qGcwKWg";


  @override
  void onInit() async {
    super.onInit();
    await fetchRandomProducts();
    print("abcdef");
    await orderController.fetchOrders(currentUserId);
    state.orders.assignAll(orderController.orders);
    state.pendingCount.value = countByStatus(state.orders, OrderStatus.pendingConfirmation, 0);
    state.deliveringCount.value = countByStatus(state.orders, OrderStatus.delivering, 2);
    countByStatus(state.orders, OrderStatus.delivered, 3);
    state.pendingShipmentCount.value = countByStatus(state.orders, OrderStatus.pendingShipment, 1);
    print("abcdefgh");
    print(state.pendingCount.value);
    print(state.deliveringCount.value);
    print(state.pendingShipment);
    printLog("abcdefghe", level: LogLevel.warning);

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

  int countByStatus(List<OrderModel> orders, OrderStatus status, int category) {
    List<OrderModel> filtered = [];

    for (var order in orders) {
      if (order.status == status) {
        filtered.add(order);
      }
    }

    // Gán danh sách đã lọc vào map
    state.categorizedOrders[category] = filtered;

    return filtered.length;

  }
}