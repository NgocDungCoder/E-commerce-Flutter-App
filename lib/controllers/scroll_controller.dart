import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollControllerX extends GetxController {
  final ScrollController scrollController = ScrollController();
  var showLottie = false.obs; // Trạng thái của hiệu ứng Lottie

  void scrollToTop() {
    print("showLottie.valu: ${showLottie.value}");
    showLottie.value = true;
    print("showLottie.valu: ${showLottie.value}");
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.linear,
    ).then((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        showLottie.value = false;
      });
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
