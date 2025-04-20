import 'package:get/get.dart';

import '../../models/order_model.dart';

class OrderState {
  var currentTabIndex = 0.obs;
  var isLoading = false.obs;
  var product = <String, dynamic>{}.obs;
  var products = <dynamic>[].obs; // Danh sách sản phẩm
  var orderProducts = <String, List<dynamic>>{}.obs;
// key: orderId (hoặc unique id), value: danh sách sản phẩm trong order đó
  late Map<int, List<OrderModel>> categorizedOrders;

  final List<String> tabs = [
    'Chờ xác nhận',
    'Chờ lấy hàng',
    'Chờ giao hàng',
    'Đã giao',
    'Đã hủy'
  ];


}