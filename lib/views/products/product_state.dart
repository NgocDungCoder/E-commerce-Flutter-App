import 'package:get/get.dart';

class ProductState {
  var products = <dynamic>[].obs; // Danh sách sản phẩm
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var isInitialLoading = true.obs; // Đang tải dữ liệu lần đầu
  var currentPage = 1.obs; // Trang hiện tại
  int itemsPerPage = 10; // Số sản phẩm trên mỗi trang
  RxInt totalProducts = 0.obs;
  int get totalPages => (totalProducts / itemsPerPage).ceil();
  var isListView = true.obs;
}

