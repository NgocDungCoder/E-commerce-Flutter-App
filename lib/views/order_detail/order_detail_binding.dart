import 'package:get/get.dart';
import 'order_detail_logic.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    try {
      Get.lazyPut(() => OrderDetailLogic());  // Dùng '??' để đảm bảo có giá trị mặc định
    } catch (e) {
      print("Lỗi trong: $e");
    }
  }
}
