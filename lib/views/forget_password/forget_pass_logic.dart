import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/route.dart';

class ForgetPassLogic extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  void resetPassword(String email) async {
     bool success = await authController.resetPassword(email);
     if (success) {
       Get.snackbar(
         "Thành công",
         "Kiểm tra trong email để đổi mật khẩu",
         snackPosition: SnackPosition.TOP,
         backgroundColor: Colors.green,
         colorText: Colors.white,
         duration: Duration(milliseconds: 2500),
       );
       // Chuyển hướng về màn hình đăng nhập
       Get.offAllNamed(Routes.login.p);
     } else {
       Get.snackbar(
         "Lỗi",
         "Bị lỗi khi lấy lại mật khẩu",
         snackPosition: SnackPosition.TOP,
         backgroundColor: Colors.red,
         duration: Duration(seconds: 1),
         colorText: Colors.white,
       );
     }
   }
}
