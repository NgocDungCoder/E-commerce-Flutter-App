import 'package:ecomercy_app_flutter/views/checkout/checkout_logic.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutLogic>(() => CheckoutLogic());
  }
}
