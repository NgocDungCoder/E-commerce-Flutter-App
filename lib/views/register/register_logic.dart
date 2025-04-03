import 'package:ecomercy_app_flutter/views/login/login_state.dart';
import 'package:ecomercy_app_flutter/views/register/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

import '../../configs/enum/load_status.dart';
import '../../controllers/auth_controller.dart';
// import '../../enum/load_status.dart';
import '../../routes/route.dart';


class RegisterLogic extends GetxController {
  final AuthController authController;
  final Routing? nextPage;
  RegisterLogic(this.authController, {this.nextPage});
  final state =  RegisterState();
  final box = GetStorage();

  final loadStatus = Rx(LoadStatus.initial);

  void register() async{

    bool success = await authController.register(state.email.value, state.password.value);

    if (success) {
      Get.snackbar(
        "Thành công",
        "Đăng ký tài khoản thành công!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
      // Chuyển hướng về màn hình đăng nhập
      Get.offAllNamed(Routes.login.p);
    } else {
      Get.snackbar(
        "Lỗi",
        "Đăng ký thất bại, vui lòng thử lại!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        colorText: Colors.white,
      );
    }
  }

  void checkMatch() {
    state.isMatch.value = (state.password.value == state.confirmPassword.value);
  }

  void validateEmail(String value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+$'; // xxx@xxx
    state.isValidEmail.value = RegExp(pattern).hasMatch(value);
  }


  void toggleObscure() {
    state.isObscure.value = !state.isObscure.value;
  }
}
