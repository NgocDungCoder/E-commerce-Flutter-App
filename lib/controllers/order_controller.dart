import 'package:get/get.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderController extends GetxController {
  final OrderService _orderService = OrderService();
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  Future<void> fetchOrders(String uid) async {
    final result = await _orderService.getOrders(uid);
    orders.value = result;
    print(orders.length);

  }

  List<OrderModel> getOrdersByStatus(String status) {
    return orders.where((o) => o.status == status).toList();
  }
}
