import 'package:get/get.dart';

class CartState {
  var isLoading = true.obs;
  var isIndicatorLoding = true.obs;
  var itemCount = 0.obs;
  var subTotal = 0.obs;
  var productsOfCart = <dynamic>[].obs;
  var productsDetail = <dynamic>[].obs;
}