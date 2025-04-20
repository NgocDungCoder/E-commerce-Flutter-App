import 'dart:async';

import 'package:ecomercy_app_flutter/views/main/main_state.dart';
import 'package:ecomercy_app_flutter/views/main/notification/nontification_logic.dart';
import 'package:ecomercy_app_flutter/views/main/profile/profile_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/product_service.dart';
import '../../utils/printLog.dart';
import 'home/home_logic.dart';

class MainLogic extends GetxController {
  final state = MainState();
  final _productService = ProductService();

  @override
  void onInit() async {
    super.onInit();
    final int? index = Get.arguments;
    if (index != null) {
      state.currentIndex.value = index;
    }
    printLog("abcdefghe", level: LogLevel.warning);
  }


  void changeTab(int index) {
    print("đã vô");
    handleTabChange(index);
  }

  void handleTabChange(int index) {
    if (index == state.currentIndex.value) return;
    print("đã vô handle");
    print(index);


    switch(index) {
      case 0:
        if (!Get.isRegistered<HomeLogic>()) {
          Get.lazyPut(() => HomeLogic());
        }
        break;
      case 1:
        if (!Get.isRegistered<NotiLogic>()) {
          Get.lazyPut(() => NotiLogic());
        }
        break;
      case 2:
        if (!Get.isRegistered<ProfileLogic>()) {
          Get.lazyPut(() => ProfileLogic());
        }
        break;
    }
    state.currentIndex.value = index;
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    update(); // Cập nhật UI ngay sau khi controller sẵn sàng
  }


}