import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';

class CheckoutState {
  var defaultValue = 0.obs; //address mặc định
  var selectedAddress = 0.obs; // Chỉ số của nút được chọn khi chọn địa chỉ
  var isLoading = true.obs;
  var temp = "abc".obs;
  final List<String> paymentMethods = [
    "Thanh toán khi nhận hàng",
    "Thanh toán qua ví điện tử",
    "Thẻ tín dụng/Ghi nợ",
  ];
  final List<IconData> iconPaymentMethods = [
    Icons.payments_outlined,
    Icons.payment_sharp,
    Icons.wallet,
  ];

  var addresses = <AddressModel>[].obs;

}