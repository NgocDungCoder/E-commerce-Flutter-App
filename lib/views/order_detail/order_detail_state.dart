import 'package:get/get.dart';
class OrderDetailState {
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var orderID = "".obs;
  var order = <String, dynamic>{}.obs;
  var productsOfOrder = <dynamic>[].obs; //danh sách id sản phẩm
  var productsDetail = <dynamic>[].obs; //chi tiết các sản phẩm lấy từ id
  var products = <dynamic>[].obs; // Danh sách sản phẩm you also like,
  RxDouble subToTal = 0.0.obs;
  RxDouble discount = 0.0.obs;
  var showDetail1 = false.obs;
  var showDetail2 = false.obs;
}