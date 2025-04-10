import 'package:get/get.dart';
import 'bill_detail_logic.dart';

class BillDetailBinding extends Bindings {
  @override
  void dependencies() {
    try {
      Get.lazyPut(() => BillDetailLogic());  // Dùng '??' để đảm bảo có giá trị mặc định
    } catch (e) {
      print("Lỗi trong: $e");
    }
  }
}
