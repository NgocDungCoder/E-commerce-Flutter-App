import 'package:get/get.dart';
import 'product_detail_logic.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailLogic>(() => ProductDetailLogic());
  }
}
