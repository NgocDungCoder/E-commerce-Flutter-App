import 'package:get/get.dart';

import '../../../models/order_model.dart';

class ProfileState {
  var products = <dynamic>[].obs; // Danh sách sản phẩm,
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var isInitialLoading = true.obs; // Đang tải dữ liệu lần đầu
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  var pendingCount = 0.obs;
  var pendingShipmentCount = 0.obs;
  var deliveringCount = 0.obs;
  var pendingShipment = 0.obs;
  var temp = 10.obs;
  Map<int, List<OrderModel>> categorizedOrders = {
    0: [], //chờ xác nhận
    1: [], //Chờ lấy hàng
    2: [], //Chờ giao hàng
    3: [], //Đã giao
  };
}
