import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/route.dart';

class LoginOTPLogic extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var isLoading = false.obs;

  void loginOTP(String phone) async {
    await authController.sendOTP(phone);
    Future.delayed(Duration(milliseconds: 2000), () {
      isLoading.value = false;
    });

  }
}
