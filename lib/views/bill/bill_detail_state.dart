import 'package:get/get.dart';
class BillDetailState {
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var orderID = "".obs;
  var order = <String, dynamic>{}.obs;
  var productsOfOrder = <dynamic>[].obs;
  var productsDetail = <dynamic>[].obs;
}