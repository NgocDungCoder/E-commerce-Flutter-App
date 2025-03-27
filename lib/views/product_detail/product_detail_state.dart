import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailState {
  var productId = ''.obs;
  var isDropdownOpen = false.obs;
  RxList<bool> isDropdownOpenList = [false, false, false].obs;
  var product = <String, dynamic>{}.obs;
  var products = <dynamic>[].obs; // Danh sách sản phẩm
  var isLoading = false.obs; // Đang tải dữ liệu (cho refresh, load thêm)
  var isInitialLoading = true.obs; // Đang tải dữ liệu lần đầu
  var currentPage = 1.obs; // Trang hiện tại
  var itemsPerPage = 8.obs; // Số sản phẩm trên mỗi trang
  List<Map<String, dynamic>> shippingOptions = [
    {'title': 'Free Flat Rate Shipping', 'icon': Icons.local_shipping_outlined,'date': '09/11/2021 - 12/11/2021', 'content': 'There are many variations of passages of Lorem Ipsum available'},
    {'title': 'Express Shipping','icon': Icons.discount_outlined, 'date': '06/11/2021 - 08/11/2021', 'content': 'Lorem Ipsum available'},
    {'title': 'Same Day Delivery', 'icon': Icons.sync, 'date': 'Today before 5 PM', 'content': 'There are many variations of passages '},
  ];
}
