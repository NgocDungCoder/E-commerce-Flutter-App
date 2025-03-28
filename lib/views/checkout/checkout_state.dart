import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutState {
  var selectedValue = 1.obs; // Chỉ số của nút được chọn
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
}