import 'package:ecomercy_app_flutter/views/cart/cart_logic.dart';
import 'package:ecomercy_app_flutter/views/checkout/checkout_state.dart';
import 'package:get/get.dart';

class CheckoutLogic extends GetxController {
  final CartLogic cartLogic = Get.find<CartLogic>();
  final state = CheckoutState();
}