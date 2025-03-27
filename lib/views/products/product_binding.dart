import 'package:ecomercy_app_flutter/views/products/product_logic.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductLogic>(() => ProductLogic());
  }
}