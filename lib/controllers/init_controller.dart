import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../exceptions/exception_handler.dart';
import 'auth_controller.dart';
import '../views/cart/cart_logic.dart';

Future initControllers() async {
  try {
    await Get.putAsync(() => AuthController().init());
    Get.put(CartLogic()); // Khởi tạo controller cho toàn ứng dụng
    //permanent: true
    // Giữ SnapshotController trong bộ nhớ vĩnh viễn (không bị xóa khi không còn sử dụng).
    //Dùng StreamController để quản lý dữ liệu từ Firestore
    Get.put(SnapshotController(), permanent: true);
  } catch (e) {
    // ExceptionHandler.instance.captureException(e);
    print('Lỗi trong init_controller');
  }
}
